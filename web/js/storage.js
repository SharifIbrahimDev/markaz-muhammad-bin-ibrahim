/**
 * Taskar Ajiya ta Waya da Kwamfuta (Storage & Cache Manager)
 */

class StorageManager {
  constructor() {
    this.initData();
  }

  initData() {
    const DATA_VERSION = "v9_markaz_11_pdf_editions_ready";
    const currentVer = localStorage.getItem("markaz_data_version");
    
    if (currentVer !== DATA_VERSION) {
      localStorage.setItem("markaz_books", JSON.stringify(INITIAL_DATA.books));
      localStorage.setItem("markaz_audios", JSON.stringify(INITIAL_DATA.audios));
      localStorage.setItem("markaz_videos", JSON.stringify(INITIAL_DATA.videos));
      localStorage.setItem("markaz_schedule", JSON.stringify(INITIAL_DATA.schedule));
      localStorage.setItem("markaz_data_version", DATA_VERSION);
    } else {
      if (!localStorage.getItem("markaz_books")) {
        localStorage.setItem("markaz_books", JSON.stringify(INITIAL_DATA.books));
      }
      if (!localStorage.getItem("markaz_audios")) {
        localStorage.setItem("markaz_audios", JSON.stringify(INITIAL_DATA.audios));
      }
      if (!localStorage.getItem("markaz_videos")) {
        localStorage.setItem("markaz_videos", JSON.stringify(INITIAL_DATA.videos));
      }
      if (!localStorage.getItem("markaz_schedule")) {
        localStorage.setItem("markaz_schedule", JSON.stringify(INITIAL_DATA.schedule));
      }
    }
    if (!localStorage.getItem("markaz_favorites")) {
      localStorage.setItem("markaz_favorites", JSON.stringify([]));
    }
    if (!localStorage.getItem("markaz_reading_history")) {
      localStorage.setItem("markaz_reading_history", JSON.stringify([]));
    }
  }

  getBooks() {
    try {
      return JSON.parse(localStorage.getItem("markaz_books")) || INITIAL_DATA.books;
    } catch (e) {
      return INITIAL_DATA.books;
    }
  }

  saveBooks(books) {
    localStorage.setItem("markaz_books", JSON.stringify(books));
    window.dispatchEvent(new CustomEvent("dataUpdated", { detail: { type: "books" } }));
  }

  addBook(book) {
    const books = this.getBooks();
    book.id = "b_" + Date.now();
    books.unshift(book);
    this.saveBooks(books);
    return book;
  }

  getAudios() {
    try {
      return JSON.parse(localStorage.getItem("markaz_audios")) || INITIAL_DATA.audios;
    } catch (e) {
      return INITIAL_DATA.audios;
    }
  }

  saveAudios(audios) {
    localStorage.setItem("markaz_audios", JSON.stringify(audios));
    window.dispatchEvent(new CustomEvent("dataUpdated", { detail: { type: "audios" } }));
  }

  addAudio(audio) {
    const audios = this.getAudios();
    audio.id = "a_" + Date.now();
    audios.unshift(audio);
    this.saveAudios(audios);
    return audio;
  }

  getVideos() {
    try {
      return JSON.parse(localStorage.getItem("markaz_videos")) || INITIAL_DATA.videos;
    } catch (e) {
      return INITIAL_DATA.videos;
    }
  }

  saveVideos(videos) {
    localStorage.setItem("markaz_videos", JSON.stringify(videos));
    window.dispatchEvent(new CustomEvent("dataUpdated", { detail: { type: "videos" } }));
  }

  addVideo(video) {
    const videos = this.getVideos();
    video.id = "v_" + Date.now();
    videos.unshift(video);
    this.saveVideos(videos);
    return video;
  }

  getSchedule() {
    try {
      return JSON.parse(localStorage.getItem("markaz_schedule")) || INITIAL_DATA.schedule;
    } catch (e) {
      return INITIAL_DATA.schedule;
    }
  }

  saveSchedule(sched) {
    localStorage.setItem("markaz_schedule", JSON.stringify(sched));
    window.dispatchEvent(new CustomEvent("dataUpdated", { detail: { type: "schedule" } }));
  }

  addScheduleItem(item) {
    const sched = this.getSchedule();
    item.id = "s_" + Date.now();
    sched.push(item);
    this.saveSchedule(sched);
    return item;
  }

  // Favorites
  getFavorites() {
    try {
      return JSON.parse(localStorage.getItem("markaz_favorites")) || [];
    } catch (e) {
      return [];
    }
  }

  isFavorite(type, id) {
    const favs = this.getFavorites();
    return favs.some(f => f.type === type && f.id === id);
  }

  toggleFavorite(item, type) {
    let favs = this.getFavorites();
    const index = favs.findIndex(f => f.type === type && f.id === item.id);
    if (index > -1) {
      favs.splice(index, 1);
    } else {
      favs.push({ type, id: item.id, item, savedAt: new Date().toISOString() });
    }
    localStorage.setItem("markaz_favorites", JSON.stringify(favs));
    window.dispatchEvent(new CustomEvent("favoritesUpdated", { detail: { favs } }));
    return index === -1; // true if added, false if removed
  }

  // Export full backup
  exportAllData() {
    const backup = {
      books: this.getBooks(),
      audios: this.getAudios(),
      videos: this.getVideos(),
      schedule: this.getSchedule(),
      exportedAt: new Date().toISOString(),
      center: INITIAL_DATA.markazInfo.nameAr
    };
    const dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(backup, null, 2));
    const dlAnchorElem = document.createElement("a");
    dlAnchorElem.setAttribute("href", dataStr);
    dlAnchorElem.setAttribute("download", `markaz_data_backup_${new Date().toISOString().slice(0,10)}.json`);
    dlAnchorElem.click();
  }

  // Import backup
  importData(jsonString) {
    try {
      const data = JSON.parse(jsonString);
      if (data.books) this.saveBooks(data.books);
      if (data.audios) this.saveAudios(data.audios);
      if (data.videos) this.saveVideos(data.videos);
      if (data.schedule) this.saveSchedule(data.schedule);
      return true;
    } catch (e) {
      console.error("Import error", e);
      return false;
    }
  }
}

const storage = new StorageManager();
if (typeof window !== "undefined") {
  window.storage = storage;
}
