// 加载图标
onload = () => lucide.createIcons();

// 加载设置文件
(function() {
  fetch(`file:///`)
})();

// 全屏
(function () {
  const btn = document.querySelector('#app-full-screen');
  const toggle = () => {
    if (btn.hasAttribute('is-full')) {
      document.exitFullscreen();
      btn.toggleAttribute('is-full');
    } else {
      document.documentElement.requestFullscreen();
      btn.toggleAttribute('is-full');
    }
  };
  btn.addEventListener('click', toggle);
  window.addEventListener('keydown', (evt) => {
    if (evt.code === 'F11') {
      evt.preventDefault();
      toggle();
    }
  });
  document.addEventListener('fullscreenchange', () => {
    const ctt = document.querySelector('#ctt');
    if (document.fullscreenElement === null) {
      btn.removeAttribute('is-full');
      btn.setAttribute('data-tooltip', '全屏');
      btn.innerHTML = /*html*/`<i data-lucide="expand"></i>`;
      lucide.createIcons();
    } else {
      btn.setAttribute('data-tooltip', '退出全屏');
      btn.innerHTML = /*html*/`<i data-lucide="shrink"></i>`;
      lucide.createIcons();
    }
  });
})();

// 皮肤切换
(function () {
  const root = document.documentElement;
  const themeBtn = document.querySelector('#app-theme');
  themeBtn.addEventListener('click', () => {
    const theme = root.getAttribute('data-theme');
    if (theme === 'light') {
      root.setAttribute('data-theme', 'dark');
      themeBtn.setAttribute('data-tooltip', '白色主题')
      themeBtn.innerHTML = /*html*/`<i data-lucide="sun"></i>`;
      lucide.createIcons();
    } else {
      root.setAttribute('data-theme', 'light');
      themeBtn.setAttribute('data-tooltip', '黑色主题');
      themeBtn.innerHTML = /*html*/`<i data-lucide="moon"></i>`;
      lucide.createIcons();
    }
  })
})();

// 界面刷新
(function () {
  const reloadBtn = document.querySelector('#page-reload-btn');
  const reloadDialog = document.querySelector('#page-reload-dialog');
  const reloadNo = document.querySelector('#page-reload-no');
  const reloadYes = document.querySelector('#page-reload-yes');
  const reloadProgress = document.querySelector('#page-reload-progress');
  reloadBtn.addEventListener('click', () => reloadDialog.setAttribute('open', true));
  reloadNo.addEventListener('click', () => reloadDialog.setAttribute('open', false));
  reloadYes.addEventListener('click', async () => {
    reloadProgress.removeAttribute('hidden');
    document.querySelector('#page-reload-dialog h2').innerText = '刷新中...';
    const max = 10;
    let value = 0;
    function timer() {
      if (value < max) {
        value++;
        reloadProgress.setAttribute('value', value);
      } else {
        clearInterval(si);
        location.reload();
      }
    }
    const si = await setInterval(timer, 100);
  });
})();