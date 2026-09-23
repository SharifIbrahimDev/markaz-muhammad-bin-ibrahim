/**
 * Mai Kunna Sautin Karatuttuka (Islamic Audio Player Engine)
 */

class AudioPlayerManager {
  constructor() {
    this.audio = new Audio();
    this.currentTrack = null;
    this.playlist = [];
    this.currentIndex = 0;
    this.isPlaying = false;
    this.playbackRate = 1.0;

    this.initElements();
    this.initEvents();
  }

  initElements() {
    this.playerContainer = document.getElementById("persistentAudioPlayer");
    this.playBtn = document.getElementById("playerPlayBtn");
    this.prevBtn = document.getElementById("playerPrevBtn");
    this.nextBtn = document.getElementById("playerNextBtn");
    this.rewindBtn = document.getElementById("playerRewindBtn");
    this.forwardBtn = document.getElementById("playerForwardBtn");
    this.titleEl = document.getElementById("playerTrackTitle");
    this.speakerEl = document.getElementById("playerTrackSpeaker");
    this.currentTimeEl = document.getElementById("playerCurrentTime");
    this.totalTimeEl = document.getElementById("playerTotalTime");
    this.progressBar = document.getElementById("playerProgressBar");
    this.volumeSlider = document.getElementById("playerVolumeSlider");
    this.speedBtn = document.getElementById("playerSpeedBtn");
    this.closeBtn = document.getElementById("playerCloseBtn");
    this.downloadBtn = document.getElementById("playerDownloadBtn");
  }

  initEvents() {
    this.audio.addEventListener("timeupdate", () => this.onTimeUpdate());
    this.audio.addEventListener("loadedmetadata", () => this.onMetadataLoaded());
    this.audio.addEventListener("ended", () => this.onTrackEnded());
    this.audio.addEventListener("play", () => {
      this.isPlaying = true;
      this.updatePlayStateUI();
    });
    this.audio.addEventListener("pause", () => {
      this.isPlaying = false;
      this.updatePlayStateUI();
    });

    if (this.playBtn) {
      this.playBtn.addEventListener("click", () => this.togglePlay());
    }
    if (this.rewindBtn) {
      this.rewindBtn.addEventListener("click", () => this.seekBy(-10));
    }
    if (this.forwardBtn) {
      this.forwardBtn.addEventListener("click", () => this.seekBy(10));
    }
    if (this.prevBtn) {
      this.prevBtn.addEventListener("click", () => this.playPrevious());
    }
    if (this.nextBtn) {
      this.nextBtn.addEventListener("click", () => this.playNext());
    }
    if (this.progressBar) {
      this.progressBar.addEventListener("input", (e) => this.onSeek(e));
    }
    if (this.volumeSlider) {
      this.volumeSlider.addEventListener("input", (e) => {
        this.audio.volume = parseFloat(e.target.value);
      });
    }
    if (this.speedBtn) {
      this.speedBtn.addEventListener("click", () => this.cyclePlaybackSpeed());
    }
    if (this.closeBtn) {
      this.closeBtn.addEventListener("click", () => this.hidePlayer());
    }
  }

  playTrack(track, playlist = []) {
    if (!track) return;
    this.currentTrack = track;
    this.playlist = playlist.length > 0 ? playlist : [track];
    this.currentIndex = this.playlist.findIndex(t => t.id === track.id);
    if (this.currentIndex === -1) this.currentIndex = 0;

    this.audio.src = track.audioUrl;
    this.audio.playbackRate = this.playbackRate;
    this.audio.play().catch(e => console.log("Audio play allowed on user action:", e));

    this.updateTrackInfoUI();
    this.showPlayer();
  }

  togglePlay() {
    if (!this.currentTrack) return;
    if (this.isPlaying) {
      this.audio.pause();
    } else {
      this.audio.play();
    }
  }

  seekBy(seconds) {
    if (!this.audio.duration) return;
    this.audio.currentTime = Math.max(0, Math.min(this.audio.duration, this.audio.currentTime + seconds));
  }

  onSeek(e) {
    if (!this.audio.duration) return;
    const seekTime = (parseFloat(e.target.value) / 100) * this.audio.duration;
    this.audio.currentTime = seekTime;
  }

  playNext() {
    if (this.playlist.length <= 1) return;
    this.currentIndex = (this.currentIndex + 1) % this.playlist.length;
    this.playTrack(this.playlist[this.currentIndex], this.playlist);
  }

  playPrevious() {
    if (this.playlist.length <= 1) return;
    this.currentIndex = (this.currentIndex - 1 + this.playlist.length) % this.playlist.length;
    this.playTrack(this.playlist[this.currentIndex], this.playlist);
  }

  onTrackEnded() {
    if (this.playlist.length > 1 && this.currentIndex < this.playlist.length - 1) {
      this.playNext();
    } else {
      this.isPlaying = false;
      this.updatePlayStateUI();
    }
  }

  cyclePlaybackSpeed() {
    const speeds = [1.0, 1.25, 1.5, 1.75, 2.0, 0.75];
    const currIndex = speeds.indexOf(this.playbackRate);
    this.playbackRate = speeds[(currIndex + 1) % speeds.length];
    this.audio.playbackRate = this.playbackRate;
    if (this.speedBtn) {
      this.speedBtn.textContent = this.playbackRate + "x";
    }
  }

  onTimeUpdate() {
    if (!this.audio.duration) return;
    const percent = (this.audio.currentTime / this.audio.duration) * 100;
    if (this.progressBar) this.progressBar.value = percent;
    if (this.currentTimeEl) this.currentTimeEl.textContent = this.formatTime(this.audio.currentTime);
  }

  onMetadataLoaded() {
    if (this.totalTimeEl) this.totalTimeEl.textContent = this.formatTime(this.audio.duration);
  }

  formatTime(secs) {
    if (isNaN(secs) || secs === Infinity) return "00:00";
    const m = Math.floor(secs / 60);
    const s = Math.floor(secs % 60);
    const mm = m < 10 ? "0" + m : m;
    const ss = s < 10 ? "0" + s : s;
    return `${mm}:${ss}`;
  }

  updateTrackInfoUI() {
    if (!this.currentTrack) return;
    const title = window.i18n ? window.i18n.getLocalizedField(this.currentTrack, "title") : this.currentTrack.titleAr;
    const speaker = window.i18n ? window.i18n.getLocalizedField(this.currentTrack, "speaker") : this.currentTrack.speakerAr;

    if (this.titleEl) this.titleEl.textContent = title;
    if (this.speakerEl) this.speakerEl.textContent = speaker;
    if (this.downloadBtn) {
      this.downloadBtn.href = this.currentTrack.audioUrl;
      this.downloadBtn.setAttribute("download", `${title}.mp3`);
    }
  }

  updatePlayStateUI() {
    if (this.playBtn) {
      this.playBtn.innerHTML = this.isPlaying
        ? `<svg width="22" height="22" viewBox="0 0 24 24" fill="currentColor"><rect x="6" y="4" width="4" height="16" rx="1"/><rect x="14" y="4" width="4" height="16" rx="1"/></svg>`
        : `<svg width="22" height="22" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>`;
    }
    // Highlight currently playing card in the view
    document.querySelectorAll(".audio-card-btn").forEach(btn => {
      if (btn.dataset.id === (this.currentTrack && this.currentTrack.id)) {
        btn.classList.toggle("is-playing", this.isPlaying);
      } else {
        btn.classList.remove("is-playing");
      }
    });
  }

  showPlayer() {
    if (this.playerContainer) {
      this.playerContainer.classList.add("active");
    }
  }

  hidePlayer() {
    if (this.playerContainer) {
      this.playerContainer.classList.remove("active");
    }
    this.audio.pause();
    this.isPlaying = false;
    this.updatePlayStateUI();
  }
}

const audioPlayer = new AudioPlayerManager();
if (typeof window !== "undefined") {
  window.audioPlayer = audioPlayer;
}
