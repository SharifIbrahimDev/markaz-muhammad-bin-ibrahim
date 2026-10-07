/**
 * Main Application Logic
 * مركز محمد بن إبراهيم آل الشيخ رحمه الله
 */

document.addEventListener("DOMContentLoaded", () => {
  // Initialize App
  initTheme();
  initLanguage();
  initTabs();
  initSearchAndFilters();
  renderAllSections();
  initModals();

  // Listeners for dynamic updates
  window.addEventListener("languageChanged", () => {
    renderAllSections();
    updateThemeTexts();
  });

  window.addEventListener("dataUpdated", () => {
    renderAllSections();
  });

  window.addEventListener("favoritesUpdated", () => {
    renderFavorites();
  });
});

/* ==========================================================
   THEME TOGGLE
   ========================================================== */
function initTheme() {
  const savedTheme = localStorage.getItem("markaz_theme") || "light";
  document.documentElement.setAttribute("data-theme", savedTheme);

  const themeToggleBtn = document.getElementById("themeToggleBtn");
  if (themeToggleBtn) {
    themeToggleBtn.addEventListener("click", () => {
      const currentTheme = document.documentElement.getAttribute("data-theme");
      const newTheme = currentTheme === "dark" ? "light" : "dark";
      document.documentElement.setAttribute("data-theme", newTheme);
      localStorage.setItem("markaz_theme", newTheme);
      updateThemeIcon(newTheme);
    });
    updateThemeIcon(savedTheme);
  }
}

function updateThemeIcon(theme) {
  const iconEl = document.querySelector("#themeToggleBtn .theme-icon");
  if (iconEl) {
    iconEl.innerHTML = theme === "dark"
      ? `<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="5"/><path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42"/></svg>`
      : `<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/></svg>`;
  }
}

function updateThemeTexts() {
  // Can refresh any dynamic text if needed
}

/* ==========================================================
   LANGUAGE SWITCHER
   ========================================================== */
function initLanguage() {
  window.i18n.setLanguage(window.i18n.currentLang);

  document.querySelectorAll(".lang-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      window.i18n.setLanguage(btn.dataset.lang);
    });
  });
}

/* ==========================================================
   TAB NAVIGATION
   ========================================================== */
let currentTab = "home";

function initTabs() {
  const navLinks = document.querySelectorAll(".nav-tab-link, .mobile-nav-link");
  navLinks.forEach(link => {
    link.addEventListener("click", (e) => {
      e.preventDefault();
      const targetTab = link.dataset.tab;
      switchTab(targetTab);
    });
  });
}

function switchTab(tabId) {
  currentTab = tabId;

  // Update tabs UI
  document.querySelectorAll(".nav-tab-link, .mobile-nav-link").forEach(link => {
    if (link.dataset.tab === tabId) {
      link.classList.add("active");
    } else {
      link.classList.remove("active");
    }
  });

  // Switch content sections
  document.querySelectorAll(".tab-pane").forEach(pane => {
    pane.classList.remove("active");
  });

  const activePane = document.getElementById(`tabPane-${tabId}`);
  if (activePane) {
    activePane.classList.add("active");
    window.scrollTo({ top: 0, behavior: "smooth" });
  }
}

/* ==========================================================
   SEARCH & FILTERS
   ========================================================== */
let activeCategory = "all";
let searchQuery = "";
let currentSort = "newest";
let viewMode = "grid"; // or 'list'

function initSearchAndFilters() {
  // Global & tab search inputs
  const searchInputs = document.querySelectorAll(".search-input-field");
  searchInputs.forEach(input => {
    input.addEventListener("input", (e) => {
      searchQuery = e.target.value.toLowerCase().trim();
      renderCurrentFilteredView();
    });
  });

  // Category chips
  document.addEventListener("click", (e) => {
    const chip = e.target.closest(".category-chip");
    if (chip) {
      document.querySelectorAll(".category-chip").forEach(c => c.classList.remove("active"));
      chip.classList.add("active");
      activeCategory = chip.dataset.category;
      renderCurrentFilteredView();
    }
  });

  // Sort dropdowns
  const sortSelects = document.querySelectorAll(".sort-select");
  sortSelects.forEach(select => {
    select.addEventListener("change", (e) => {
      currentSort = e.target.value;
      renderCurrentFilteredView();
    });
  });

  // View switchers
  document.querySelectorAll(".view-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      viewMode = btn.dataset.view;
      document.querySelectorAll(".view-btn").forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
      renderBooks();
    });
  });
}

function renderCurrentFilteredView() {
  if (currentTab === "books" || currentTab === "home") renderBooks();
  if (currentTab === "audios" || currentTab === "home") renderAudios();
  if (currentTab === "videos" || currentTab === "home") renderVideos();
}

/* ==========================================================
   RENDER ALL SECTIONS
   ========================================================== */
function renderAllSections() {
  renderCategories();
  renderFeaturedHero();
  renderBooks();
  renderAudios();
  renderVideos();
  renderSchedule();
  renderFavorites();
  renderStats();
}

function renderStats() {
  const books = window.storage.getBooks();
  const audios = window.storage.getAudios();
  const videos = window.storage.getVideos();
  const schedule = window.storage.getSchedule();

  const countBooksEl = document.getElementById("statCountBooks");
  const countAudiosEl = document.getElementById("statCountAudios");
  const countVideosEl = document.getElementById("statCountVideos");
  const countCoursesEl = document.getElementById("statCountCourses");

  if (countBooksEl) countBooksEl.textContent = books.length + "+";
  if (countAudiosEl) countAudiosEl.textContent = audios.length + "+";
  if (countVideosEl) countVideosEl.textContent = videos.length + "+";
  if (countCoursesEl) countCoursesEl.textContent = schedule.length;
}

function renderCategories() {
  const container = document.getElementById("categoryChipsContainer");
  if (!container) return;

  const categories = INITIAL_DATA.categories;
  let html = "";

  categories.forEach(cat => {
    const isActive = cat.id === activeCategory ? "active" : "";
    const name = window.i18n.getLocalizedField(cat, "name");
    html += `
      <button class="category-chip ${isActive}" data-category="${cat.id}">
        <span class="chip-icon">${cat.icon}</span>
        <span class="chip-label">${name}</span>
      </button>
    `;
  });

  container.innerHTML = html;
}

function renderFeaturedHero() {
  const books = window.storage.getBooks();
  const featuredBook = books.find(b => b.featured) || books[0];
  const container = document.getElementById("heroFeaturedContainer");
  if (!container || !featuredBook) return;

  const title = window.i18n.getLocalizedField(featuredBook, "title");
  const author = window.i18n.getLocalizedField(featuredBook, "author");
  const desc = window.i18n.getLocalizedField(featuredBook, "description");

  const readUrl = featuredBook.htmlEditionUrl ? featuredBook.htmlEditionUrl : `reader.html?bookId=${featuredBook.id}`;

  container.innerHTML = `
    <div class="hero-featured-card glass-card">
      <div class="hero-featured-badge">🌟 ${window.i18n.t("featuredBooks")}</div>
      <div class="hero-featured-body">
        <div class="hero-featured-cover">
          <img src="${featuredBook.cover}" alt="${title}" loading="lazy"/>
        </div>
        <div class="hero-featured-info">
          <h3>${title}</h3>
          <p class="hero-author"><span class="icon">✍️</span> ${author}</p>
          <p class="hero-desc">${desc}</p>
          <div class="hero-meta">
            <span>📄 ${featuredBook.pages} ${window.i18n.t("pages")}</span>
            <span>💾 ${featuredBook.size}</span>
            <span>📥 ${featuredBook.downloads} ${window.i18n.t("downloads")}</span>
          </div>
          <div class="hero-actions">
            <a href="${readUrl}" class="btn btn-gold">
              <span>📖 ${window.i18n.t("readBook")}</span>
            </a>
            <a href="${featuredBook.pdfUrl}" target="_blank" download class="btn btn-outline-white">
              <span>⬇️ ${window.i18n.t("downloadPdf")}</span>
            </a>
          </div>
        </div>
      </div>
    </div>
  `;
}

/* ==========================================================
   RENDER BOOKS
   ========================================================== */
function renderBooks() {
  const container = document.getElementById("booksGridContainer");
  const homeFeaturedContainer = document.getElementById("homeFeaturedBooksContainer");
  const homeUpcomingContainer = document.getElementById("homeUpcomingBooksContainer");

  let books = window.storage.getBooks();

  // Render Homepage Upcoming Section (Sheikh Ibrahim Sharif Abubakar's publications)
  if (homeUpcomingContainer) {
    const upcomingBooks = books.filter(b => b.isUpcoming);
    homeUpcomingContainer.innerHTML = upcomingBooks.map(book => createBookCardHTML(book)).join("");
  }

  // Filter by category
  if (activeCategory === "upcoming") {
    books = books.filter(b => b.isUpcoming);
  } else if (activeCategory !== "all") {
    books = books.filter(b => b.category === activeCategory);
  }

  // Filter by search query
  if (searchQuery) {
    books = books.filter(b => {
      const tAr = (b.titleAr || "").toLowerCase();
      const tHa = (b.titleHa || "").toLowerCase();
      const tEn = (b.titleEn || "").toLowerCase();
      const aAr = (b.authorAr || "").toLowerCase();
      const aHa = (b.authorHa || "").toLowerCase();
      const dAr = (b.descriptionAr || "").toLowerCase();
      const dHa = (b.descriptionHa || "").toLowerCase();
      return tAr.includes(searchQuery) || tHa.includes(searchQuery) || tEn.includes(searchQuery) ||
             aAr.includes(searchQuery) || aHa.includes(searchQuery) || dAr.includes(searchQuery) || dHa.includes(searchQuery);
    });
  }

  // Sort
  if (currentSort === "popular") {
    books.sort((a, b) => (b.downloads || 0) - (a.downloads || 0));
  } else if (currentSort === "alphabetical") {
    books.sort((a, b) => {
      const nameA = window.i18n.getLocalizedField(a, "title");
      const nameB = window.i18n.getLocalizedField(b, "title");
      return nameA.localeCompare(nameB);
    });
  }

  if (container) {
    if (books.length === 0) {
      container.innerHTML = `<div class="empty-state"><p>🔍 ${window.i18n.t("noResults")}</p></div>`;
    } else {
      container.className = viewMode === "list" ? "books-list-view" : "books-grid-view";
      container.innerHTML = books.map(book => createBookCardHTML(book)).join("");
    }
  }

  if (homeFeaturedContainer) {
    const featured = books.filter(b => b.featured && !b.isUpcoming).slice(0, 4);
    homeFeaturedContainer.innerHTML = featured.map(book => createBookCardHTML(book)).join("");
  }
}

function filterByUpcoming() {
  activeCategory = "upcoming";
  switchTab("books");
  document.querySelectorAll(".category-chip").forEach(c => {
    if (c.dataset.category === "upcoming") {
      c.classList.add("active");
    } else {
      c.classList.remove("active");
    }
  });
  renderBooks();
}
window.filterByUpcoming = filterByUpcoming;

function createBookCardHTML(book) {
  const title = window.i18n.getLocalizedField(book, "title");
  const author = window.i18n.getLocalizedField(book, "author");
  const isFav = window.storage.isFavorite("book", book.id);
  const catObj = INITIAL_DATA.categories.find(c => c.id === book.category);
  const catName = catObj ? window.i18n.getLocalizedField(catObj, "name") : "";

  const upcomingBadgeHTML = book.isUpcoming 
    ? `<span class="upcoming-badge">⏳ ${window.i18n.t("upcomingBadge")}</span>`
    : "";

  const readUrl = book.htmlEditionUrl ? book.htmlEditionUrl : `reader.html?bookId=${book.id}`;

  const actionsHTML = book.isUpcoming
    ? `
      <button class="btn btn-gold btn-sm" style="flex: 1;" onclick="openBookModal('${book.id}')">
        <span>ℹ️ ${window.i18n.t("viewDetails")}</span>
      </button>
      <span class="badge-status-subtle">${window.i18n.t("underPublication")}</span>
    `
    : `
      <a href="${readUrl}" class="btn btn-primary btn-sm">
        <span>📖 ${window.i18n.t("readBook")}</span>
      </a>
      <button class="btn btn-outline-primary btn-sm" onclick="openBookModal('${book.id}')" title="${window.i18n.t("previewInfo")}">
        <span>ℹ️</span>
      </button>
      <a href="${book.pdfUrl}" target="_blank" download class="btn btn-gold btn-sm" title="${window.i18n.t("downloadPdf")}">
        <span>⬇️</span>
      </a>
    `;

  return `
    <div class="book-card card-lift" data-id="${book.id}">
      <div class="book-card-cover-wrapper">
        <img src="${book.cover}" alt="${title}" class="book-card-cover" loading="lazy"/>
        ${upcomingBadgeHTML}
        <button class="fav-icon-btn ${isFav ? 'is-fav' : ''}" onclick="toggleFavItem('book', '${book.id}', event)" title="${window.i18n.t('addToFavorites')}">
          ${isFav ? '❤️' : '🤍'}
        </button>
        <span class="category-badge">${catObj ? catObj.icon : '📖'} ${catName}</span>
      </div>
      <div class="book-card-content">
        <h4 class="book-card-title" title="${title}">${title}</h4>
        <p class="book-card-author"><span class="icon">✍️</span> ${author}</p>
        <div class="book-card-meta">
          <span>📄 ${book.pages} ${window.i18n.t("pages")}</span>
          <span>💾 ${book.size}</span>
        </div>
        <div class="book-card-actions">
          ${actionsHTML}
        </div>
      </div>
    </div>
  `;
}

/* ==========================================================
   RENDER AUDIOS
   ========================================================== */
function renderAudios() {
  const container = document.getElementById("audiosListContainer");
  const homeContainer = document.getElementById("homeLatestAudiosContainer");
  if (!container && !homeContainer) return;

  let audios = window.storage.getAudios();

  if (activeCategory !== "all") {
    audios = audios.filter(a => a.category === activeCategory);
  }

  if (searchQuery) {
    audios = audios.filter(a => {
      const tAr = (a.titleAr || "").toLowerCase();
      const tHa = (a.titleHa || "").toLowerCase();
      const sAr = (a.speakerAr || "").toLowerCase();
      const sHa = (a.speakerHa || "").toLowerCase();
      return tAr.includes(searchQuery) || tHa.includes(searchQuery) || sAr.includes(searchQuery) || sHa.includes(searchQuery);
    });
  }

  if (container) {
    if (audios.length === 0) {
      container.innerHTML = `<div class="empty-state"><p>🔍 ${window.i18n.t("noResults")}</p></div>`;
    } else {
      container.innerHTML = audios.map(audio => createAudioTileHTML(audio)).join("");
    }
  }

  if (homeContainer) {
    const latest = audios.slice(0, 4);
    homeContainer.innerHTML = latest.map(audio => createAudioTileHTML(audio)).join("");
  }
}

function createAudioTileHTML(audio) {
  const title = window.i18n.getLocalizedField(audio, "title");
  const speaker = window.i18n.getLocalizedField(audio, "speaker");
  const isFav = window.storage.isFavorite("audio", audio.id);
  const catObj = INITIAL_DATA.categories.find(c => c.id === audio.category);
  const catName = catObj ? window.i18n.getLocalizedField(catObj, "name") : "";

  return `
    <div class="audio-tile card-lift" data-id="${audio.id}">
      <div class="audio-tile-play-btn audio-card-btn" data-id="${audio.id}" onclick="playAudioTrack('${audio.id}')">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
      </div>
      <div class="audio-tile-info">
        <div class="audio-tile-header">
          <span class="category-pill">${catObj ? catObj.icon : '🎧'} ${catName}</span>
          <span class="audio-date">📅 ${audio.date}</span>
        </div>
        <h4 class="audio-tile-title">${title}</h4>
        <p class="audio-tile-speaker">🎙️ ${speaker}</p>
      </div>
      <div class="audio-tile-meta">
        <span class="audio-duration">⏱️ ${audio.duration}</span>
        <div class="audio-tile-actions">
          <button class="fav-icon-btn ${isFav ? 'is-fav' : ''}" onclick="toggleFavItem('audio', '${audio.id}', event)">
            ${isFav ? '❤️' : '🤍'}
          </button>
          <a href="${audio.audioUrl}" download class="btn btn-outline-primary btn-sm" title="${window.i18n.t("downloadAudio")}">
            <span>⬇️ MP3</span>
          </a>
        </div>
      </div>
    </div>
  `;
}

function playAudioTrack(id) {
  const audios = window.storage.getAudios();
  const track = audios.find(a => a.id === id);
  if (track && window.audioPlayer) {
    window.audioPlayer.playTrack(track, audios);
  }
}

/* ==========================================================
   RENDER VIDEOS
   ========================================================== */
function renderVideos() {
  const container = document.getElementById("videosGridContainer");
  const homeContainer = document.getElementById("homeLatestVideosContainer");
  if (!container && !homeContainer) return;

  let videos = window.storage.getVideos();

  if (activeCategory !== "all") {
    videos = videos.filter(v => v.category === activeCategory);
  }

  if (searchQuery) {
    videos = videos.filter(v => {
      const tAr = (v.titleAr || "").toLowerCase();
      const tHa = (v.titleHa || "").toLowerCase();
      const iAr = (v.instructorAr || "").toLowerCase();
      const iHa = (v.instructorHa || "").toLowerCase();
      return tAr.includes(searchQuery) || tHa.includes(searchQuery) || iAr.includes(searchQuery) || iHa.includes(searchQuery);
    });
  }

  if (container) {
    if (videos.length === 0) {
      container.innerHTML = `<div class="empty-state"><p>🔍 ${window.i18n.t("noResults")}</p></div>`;
    } else {
      container.innerHTML = videos.map(video => createVideoCardHTML(video)).join("");
    }
  }

  if (homeContainer) {
    const latest = videos.slice(0, 3);
    homeContainer.innerHTML = latest.map(video => createVideoCardHTML(video)).join("");
  }
}

function createVideoCardHTML(video) {
  const title = window.i18n.getLocalizedField(video, "title");
  const instructor = window.i18n.getLocalizedField(video, "instructor");
  const isFav = window.storage.isFavorite("video", video.id);

  return `
    <div class="video-card card-lift" data-id="${video.id}">
      <div class="video-thumbnail-wrapper" onclick="openVideoModal('${video.id}')">
        <img src="${video.thumbnail}" alt="${title}" class="video-thumbnail" loading="lazy"/>
        <div class="video-play-overlay">
          <div class="play-circle">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
          </div>
        </div>
        <span class="video-duration-badge">${video.duration}</span>
      </div>
      <div class="video-content">
        <h4 class="video-title" onclick="openVideoModal('${video.id}')">${title}</h4>
        <p class="video-instructor">👨‍🏫 ${instructor}</p>
        <div class="video-footer">
          <span class="video-views">👁️ ${video.views || 0} ${window.i18n.t("views")}</span>
          <button class="fav-icon-btn ${isFav ? 'is-fav' : ''}" onclick="toggleFavItem('video', '${video.id}', event)">
            ${isFav ? '❤️' : '🤍'}
          </button>
        </div>
      </div>
    </div>
  `;
}

/* ==========================================================
   RENDER SCHEDULE
   ========================================================== */
function renderSchedule() {
  const container = document.getElementById("scheduleGridContainer");
  const homeContainer = document.getElementById("homeScheduleContainer");
  if (!container && !homeContainer) return;

  const schedule = window.storage.getSchedule();

  const scheduleHTML = schedule.map(item => {
    const day = window.i18n.getLocalizedField(item, "day");
    const subject = window.i18n.getLocalizedField(item, "subject");
    const teacher = window.i18n.getLocalizedField(item, "teacher");
    const location = window.i18n.getLocalizedField(item, "location");

    return `
      <div class="schedule-card card-lift">
        <div class="schedule-day-badge">
          <span class="icon">🗓️</span>
          <span class="day-text">${day}</span>
        </div>
        <div class="schedule-details">
          <h4 class="schedule-subject">${subject}</h4>
          <p class="schedule-teacher">🎙️ <strong>${window.i18n.t("speaker")}:</strong> ${teacher}</p>
          <div class="schedule-meta-row">
            <span class="schedule-time">⏰ ${item.time}</span>
            <span class="schedule-location">📍 ${location}</span>
          </div>
        </div>
      </div>
    `;
  }).join("");

  if (container) container.innerHTML = scheduleHTML;
  if (homeContainer) homeContainer.innerHTML = scheduleHTML;
}

/* ==========================================================
   RENDER FAVORITES
   ========================================================== */
function renderFavorites() {
  const container = document.getElementById("favoritesContainer");
  if (!container) return;

  const favorites = window.storage.getFavorites();

  if (favorites.length === 0) {
    container.innerHTML = `
      <div class="empty-state">
        <span class="empty-icon">🤍</span>
        <h3>${window.i18n.t("navFavorites")}</h3>
        <p>${window.i18n.t("noFavorites")}</p>
      </div>
    `;
    return;
  }

  let html = `<div class="favorites-grid">`;
  favorites.forEach(fav => {
    if (fav.type === "book") {
      const book = window.storage.getBooks().find(b => b.id === fav.id) || fav.item;
      if (book) html += createBookCardHTML(book);
    } else if (fav.type === "audio") {
      const audio = window.storage.getAudios().find(a => a.id === fav.id) || fav.item;
      if (audio) html += createAudioTileHTML(audio);
    } else if (fav.type === "video") {
      const video = window.storage.getVideos().find(v => v.id === fav.id) || fav.item;
      if (video) html += createVideoCardHTML(video);
    }
  });
  html += `</div>`;

  container.innerHTML = html;
}

function toggleFavItem(type, id, event) {
  if (event) event.stopPropagation();
  let item = null;
  if (type === "book") item = window.storage.getBooks().find(b => b.id === id);
  if (type === "audio") item = window.storage.getAudios().find(a => a.id === id);
  if (type === "video") item = window.storage.getVideos().find(v => v.id === id);

  if (item) {
    window.storage.toggleFavorite(item, type);
    renderAllSections();
  }
}

/* ==========================================================
   MODALS (Book Details, Video Player)
   ========================================================== */
function initModals() {
  const closeBtns = document.querySelectorAll(".modal-close-btn, .modal-backdrop");
  closeBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      document.querySelectorAll(".modal-wrapper").forEach(m => m.classList.remove("active"));
      // Stop video if active
      const videoIframe = document.getElementById("videoPlayerIframe");
      if (videoIframe) videoIframe.src = "";
    });
  });
}

function openBookModal(bookId) {
  const book = window.storage.getBooks().find(b => b.id === bookId);
  if (!book) return;

  const modal = document.getElementById("bookDetailsModal");
  if (!modal) return;

  const title = window.i18n.getLocalizedField(book, "title");
  const author = window.i18n.getLocalizedField(book, "author");
  const desc = window.i18n.getLocalizedField(book, "description");
  const catObj = INITIAL_DATA.categories.find(c => c.id === book.category);
  const catName = catObj ? window.i18n.getLocalizedField(catObj, "name") : "";

  document.getElementById("modalBookTitle").textContent = title;
  document.getElementById("modalBookAuthor").textContent = author;
  document.getElementById("modalBookCategory").textContent = `${catObj ? catObj.icon : ''} ${catName}`;
  document.getElementById("modalBookPages").textContent = `${book.pages} ${window.i18n.t("pages")}`;
  document.getElementById("modalBookSize").textContent = book.size;
  document.getElementById("modalBookYear").textContent = book.year || "-";
  document.getElementById("modalBookDesc").textContent = desc;
  document.getElementById("modalBookCover").src = book.cover;

  const readBtn = document.getElementById("modalBookReadBtn");
  const dlBtn = document.getElementById("modalBookDownloadBtn");

  if (book.isUpcoming) {
    if (readBtn) readBtn.style.display = "none";
    if (dlBtn) dlBtn.style.display = "none";
  } else {
    if (readBtn) {
      readBtn.style.display = "inline-flex";
      readBtn.href = book.htmlEditionUrl ? book.htmlEditionUrl : `reader.html?bookId=${book.id}`;
    }
    if (dlBtn) {
      dlBtn.style.display = "inline-flex";
      dlBtn.href = book.pdfUrl;
      dlBtn.setAttribute("download", `${title}.pdf`);
    }
  }

  modal.classList.add("active");
}

function openVideoModal(videoId) {
  const video = window.storage.getVideos().find(v => v.id === videoId);
  if (!video) return;

  const modal = document.getElementById("videoPlayerModal");
  if (!modal) return;

  const title = window.i18n.getLocalizedField(video, "title");
  const instructor = window.i18n.getLocalizedField(video, "instructor");

  document.getElementById("modalVideoTitle").textContent = title;
  document.getElementById("modalVideoInstructor").textContent = instructor;
  
  const iframe = document.getElementById("videoPlayerIframe");
  if (iframe) {
    iframe.src = video.videoUrl;
  }

  modal.classList.add("active");
}

// Global exposure
window.switchTab = switchTab;
window.toggleFavItem = toggleFavItem;
window.openBookModal = openBookModal;
window.openVideoModal = openVideoModal;
window.playAudioTrack = playAudioTrack;
