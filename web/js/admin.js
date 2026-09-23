/**
 * Admin Panel Controller
 * مركز محمد بن إبراهيم آل الشيخ رحمه الله
 */

document.addEventListener("DOMContentLoaded", () => {
  initAdminTabs();
  renderAdminTables();
  initFormSubmissions();
  initBackupHandlers();
});

/* Admin Tabs */
function initAdminTabs() {
  const tabBtns = document.querySelectorAll(".admin-pill-btn");
  tabBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      tabBtns.forEach(b => b.classList.remove("active"));
      btn.classList.add("active");

      const target = btn.dataset.adminTab;
      document.querySelectorAll(".admin-tab-pane").forEach(pane => {
        pane.style.display = "none";
      });

      const activePane = document.getElementById(`adminTab-${target}`);
      if (activePane) activePane.style.display = "block";
    });
  });
}

/* Toast Alert */
function showToast(message) {
  const toast = document.getElementById("adminToast");
  if (toast) {
    toast.textContent = message;
    toast.style.display = "block";
    setTimeout(() => {
      toast.style.display = "none";
    }, 3500);
  }
}

/* Render Tables */
function renderAdminTables() {
  renderAdminBooks();
  renderAdminAudios();
  renderAdminVideos();
  renderAdminSchedule();
}

function renderAdminBooks() {
  const tbody = document.getElementById("adminBooksTableBody");
  if (!tbody) return;

  const books = window.storage.getBooks();
  tbody.innerHTML = books.map(book => {
    const title = window.i18n.getLocalizedField(book, "title");
    const author = window.i18n.getLocalizedField(book, "author");
    return `
      <tr>
        <td style="width: 60px;">
          <img src="${book.cover}" style="width: 40px; height: 55px; object-fit: cover; border-radius: 4px; border: 1px solid var(--gold);" />
        </td>
        <td><strong>${title}</strong></td>
        <td>${author}</td>
        <td><span class="category-pill">${book.category}</span></td>
        <td>${book.pages || "-"}</td>
        <td>
          <div class="table-actions">
            <a href="reader.html?bookId=${book.id}" target="_blank" class="btn btn-outline-primary btn-sm" title="Duba PDF">📖</a>
            <button class="btn btn-gold btn-sm" onclick="deleteAdminBook('${book.id}')" title="Goge">🗑️</button>
          </div>
        </td>
      </tr>
    `;
  }).join("");
}

function renderAdminAudios() {
  const tbody = document.getElementById("adminAudiosTableBody");
  if (!tbody) return;

  const audios = window.storage.getAudios();
  tbody.innerHTML = audios.map(audio => {
    const title = window.i18n.getLocalizedField(audio, "title");
    const speaker = window.i18n.getLocalizedField(audio, "speaker");
    return `
      <tr>
        <td><strong>${title}</strong></td>
        <td>${speaker}</td>
        <td><span class="category-pill">${audio.category}</span></td>
        <td>${audio.duration || "-"}</td>
        <td>
          <div class="table-actions">
            <button class="btn btn-gold btn-sm" onclick="deleteAdminAudio('${audio.id}')" title="Goge">🗑️</button>
          </div>
        </td>
      </tr>
    `;
  }).join("");
}

function renderAdminVideos() {
  const tbody = document.getElementById("adminVideosTableBody");
  if (!tbody) return;

  const videos = window.storage.getVideos();
  tbody.innerHTML = videos.map(video => {
    const title = window.i18n.getLocalizedField(video, "title");
    return `
      <tr>
        <td style="width: 80px;">
          <img src="${video.thumbnail}" style="width: 70px; height: 45px; object-fit: cover; border-radius: 4px;" />
        </td>
        <td><strong>${title}</strong></td>
        <td>${video.instructor}</td>
        <td>${video.duration || "-"}</td>
        <td>
          <div class="table-actions">
            <button class="btn btn-gold btn-sm" onclick="deleteAdminVideo('${video.id}')" title="Goge">🗑️</button>
          </div>
        </td>
      </tr>
    `;
  }).join("");
}

function renderAdminSchedule() {
  const tbody = document.getElementById("adminScheduleTableBody");
  if (!tbody) return;

  const sched = window.storage.getSchedule();
  tbody.innerHTML = sched.map(item => {
    return `
      <tr>
        <td><strong>${item.dayHa || item.dayAr}</strong></td>
        <td>${item.time}</td>
        <td>${item.subjectHa || item.subjectAr}</td>
        <td>${item.teacherHa || item.teacherAr}</td>
        <td>${item.locationHa || item.locationAr}</td>
        <td>
          <div class="table-actions">
            <button class="btn btn-gold btn-sm" onclick="deleteAdminSchedule('${item.id}')" title="Goge">🗑️</button>
          </div>
        </td>
      </tr>
    `;
  }).join("");
}

/* Deletions */
function deleteAdminBook(id) {
  if (confirm(window.i18n.t("confirmDelete"))) {
    let books = window.storage.getBooks();
    books = books.filter(b => b.id !== id);
    window.storage.saveBooks(books);
    renderAdminBooks();
    showToast("An goge littafin cikin nasara!");
  }
}

function deleteAdminAudio(id) {
  if (confirm(window.i18n.t("confirmDelete"))) {
    let audios = window.storage.getAudios();
    audios = audios.filter(a => a.id !== id);
    window.storage.saveAudios(audios);
    renderAdminAudios();
    showToast("An goge sautin karatun cikin nasara!");
  }
}

function deleteAdminVideo(id) {
  if (confirm(window.i18n.t("confirmDelete"))) {
    let videos = window.storage.getVideos();
    videos = videos.filter(v => v.id !== id);
    window.storage.saveVideos(videos);
    renderAdminVideos();
    showToast("An goge bidiyon cikin nasara!");
  }
}

function deleteAdminSchedule(id) {
  if (confirm(window.i18n.t("confirmDelete"))) {
    let sched = window.storage.getSchedule();
    sched = sched.filter(s => s.id !== id);
    window.storage.saveSchedule(sched);
    renderAdminSchedule();
    showToast("An goge zaman jadawalin!");
  }
}

/* Form Submissions */
function initFormSubmissions() {
  // Add Book Form
  const addBookForm = document.getElementById("addBookForm");
  if (addBookForm) {
    addBookForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const newBook = {
        titleHa: document.getElementById("bookTitleHa").value.trim(),
        titleAr: document.getElementById("bookTitleAr").value.trim(),
        titleEn: document.getElementById("bookTitleHa").value.trim(),
        authorHa: document.getElementById("bookAuthorHa").value.trim(),
        authorAr: document.getElementById("bookAuthorAr").value.trim() || document.getElementById("bookAuthorHa").value.trim(),
        authorEn: document.getElementById("bookAuthorHa").value.trim(),
        category: document.getElementById("bookCategory").value,
        pages: parseInt(document.getElementById("bookPages").value) || 120,
        size: "4.5 MB",
        cover: document.getElementById("bookCover").value.trim() || "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=600&q=80",
        pdfUrl: document.getElementById("bookPdfUrl").value.trim(),
        descriptionHa: document.getElementById("bookDesc").value.trim() || "Bayanin littafi daga Markaz Muhammad bin Ibrahim.",
        descriptionAr: document.getElementById("bookDesc").value.trim(),
        featured: false,
        downloads: 1
      };

      window.storage.addBook(newBook);
      addBookForm.reset();
      renderAdminBooks();
      showToast(window.i18n.t("successAdded"));
    });
  }

  // Add Audio Form
  const addAudioForm = document.getElementById("addAudioForm");
  if (addAudioForm) {
    addAudioForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const newAudio = {
        titleHa: document.getElementById("audioTitleHa").value.trim(),
        titleAr: document.getElementById("audioTitleAr").value.trim(),
        titleEn: document.getElementById("audioTitleHa").value.trim(),
        speakerHa: document.getElementById("audioSpeakerHa").value.trim(),
        speakerAr: document.getElementById("audioSpeakerAr").value.trim() || document.getElementById("audioSpeakerHa").value.trim(),
        speakerEn: document.getElementById("audioSpeakerHa").value.trim(),
        category: document.getElementById("audioCategory").value,
        duration: document.getElementById("audioDuration").value.trim() || "40:00",
        audioUrl: document.getElementById("audioUrl").value.trim(),
        date: new Date().toISOString().slice(0, 10),
        fileSize: "18 MB",
        featured: false
      };

      window.storage.addAudio(newAudio);
      addAudioForm.reset();
      renderAdminAudios();
      showToast(window.i18n.t("successAdded"));
    });
  }

  // Add Video Form
  const addVideoForm = document.getElementById("addVideoForm");
  if (addVideoForm) {
    addVideoForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const newVideo = {
        titleHa: document.getElementById("videoTitleHa").value.trim(),
        titleAr: document.getElementById("videoTitleAr").value.trim(),
        titleEn: document.getElementById("videoTitleHa").value.trim(),
        instructor: document.getElementById("videoInstructor").value.trim(),
        instructorAr: document.getElementById("videoInstructor").value.trim(),
        duration: document.getElementById("videoDuration").value.trim() || "45:00",
        thumbnail: document.getElementById("videoThumbnail").value.trim() || "https://images.unsplash.com/photo-1590076215667-875d4ef2d7ee?auto=format&fit=crop&w=800&q=80",
        videoUrl: document.getElementById("videoUrl").value.trim(),
        category: "lessons",
        date: new Date().toISOString().slice(0, 10),
        views: 1
      };

      window.storage.addVideo(newVideo);
      addVideoForm.reset();
      renderAdminVideos();
      showToast(window.i18n.t("successAdded"));
    });
  }

  // Add Schedule Form
  const addScheduleForm = document.getElementById("addScheduleForm");
  if (addScheduleForm) {
    addScheduleForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const newItem = {
        dayHa: document.getElementById("scheduleDay").value,
        dayAr: document.getElementById("scheduleDay").value,
        time: document.getElementById("scheduleTime").value.trim(),
        subjectHa: document.getElementById("scheduleSubject").value.trim(),
        subjectAr: document.getElementById("scheduleSubject").value.trim(),
        teacherHa: document.getElementById("scheduleTeacher").value.trim(),
        teacherAr: document.getElementById("scheduleTeacher").value.trim(),
        locationHa: document.getElementById("scheduleLocation").value.trim(),
        locationAr: document.getElementById("scheduleLocation").value.trim()
      };

      window.storage.addScheduleItem(newItem);
      addScheduleForm.reset();
      renderAdminSchedule();
      showToast(window.i18n.t("successAdded"));
    });
  }
}

/* Backup & Restore Handlers */
function initBackupHandlers() {
  const exportBtn = document.getElementById("exportBackupBtn");
  const importBtn = document.getElementById("importBackupBtn");
  const fileInput = document.getElementById("importFileInput");

  if (exportBtn) {
    exportBtn.addEventListener("click", () => {
      window.storage.exportAllData();
      showToast("An sauke backup din bayanan cikin nasara!");
    });
  }

  if (importBtn && fileInput) {
    importBtn.addEventListener("click", () => fileInput.click());

    fileInput.addEventListener("change", (e) => {
      const file = e.target.files[0];
      if (!file) return;

      const reader = new FileReader();
      reader.onload = (event) => {
        const success = window.storage.importData(event.target.result);
        if (success) {
          renderAdminTables();
          showToast("An shigar da sabbin bayanan cikin nasara!");
        } else {
          alert("Kuskure wajen karanta fayil din backup!");
        }
      };
      reader.readAsText(file);
    });
  }
}

// Expose globals for inline onclicks
window.deleteAdminBook = deleteAdminBook;
window.deleteAdminAudio = deleteAdminAudio;
window.deleteAdminVideo = deleteAdminVideo;
window.deleteAdminSchedule = deleteAdminSchedule;
