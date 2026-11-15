<script setup>
const route = useRoute();
const menuOpen = ref(false);
const menuButton = ref(null);
const activeSection = ref('home');
let sectionObserver;

const links = [
  { label: 'Home', to: '/#home', section: 'home' },
  { label: 'About', to: '/#about', section: 'about' },
  { label: 'Skills', to: '/#skills', section: 'skills' },
  { label: 'Work', to: '/#work', section: 'work' },
  { label: 'Experience', to: '/#experience', section: 'experience' },
  { label: "Let's Talk", to: '/#contact', section: 'contact', cta: true },
];

function observeSections() {
  sectionObserver?.disconnect();
  if (route.path !== '/') {
    activeSection.value = route.path === '/projects' ? 'work' : 'home';
    return;
  }

  nextTick(() => {
    const sections = document.querySelectorAll('#home, #about, #skills, #work, #experience, #contact');
    if (!sections.length || !('IntersectionObserver' in window)) return;
    sectionObserver = new IntersectionObserver((entries) => {
      const visible = entries
        .filter((entry) => entry.isIntersecting)
        .sort((first, second) => first.boundingClientRect.top - second.boundingClientRect.top);
      if (visible[0]) activeSection.value = visible[0].target.id;
    }, { rootMargin: '-18% 0px -66% 0px', threshold: 0 });
    sections.forEach((section) => sectionObserver.observe(section));
  });
}

function closeMenu() {
  menuOpen.value = false;
}

function onKeydown(event) {
  if (event.key === 'Escape' && menuOpen.value) {
    closeMenu();
    menuButton.value?.focus();
  }
}

watch(() => route.path, () => {
  closeMenu();
  observeSections();
}, { flush: 'post' });

onMounted(() => {
  observeSections();
  window.addEventListener('keydown', onKeydown);
});

onBeforeUnmount(() => {
  sectionObserver?.disconnect();
  window.removeEventListener('keydown', onKeydown);
});
</script>

<template>
  <header class="site-header">
    <div class="nav-shell">
      <NuxtLink class="wordmark" to="/#home" aria-label="Hafizh home" @click="closeMenu">
        hafizh<span>.</span>
      </NuxtLink>

      <button
        ref="menuButton"
        class="menu-toggle"
        type="button"
        :aria-expanded="menuOpen"
        aria-controls="portfolio-navigation"
        :aria-label="menuOpen ? 'Close navigation menu' : 'Open navigation menu'"
        @click="menuOpen = !menuOpen"
      >
        <svg v-if="!menuOpen" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M4 7h16M4 12h16M4 17h16" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" />
        </svg>
        <svg v-else viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="m6 6 12 12M18 6 6 18" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" />
        </svg>
      </button>

      <nav id="portfolio-navigation" class="primary-nav" aria-label="Main navigation" :data-open="menuOpen">
        <ul>
          <li v-for="link in links" :key="link.section">
            <NuxtLink
              :to="link.to"
              :class="{ 'nav-cta': link.cta }"
              :aria-current="activeSection === link.section || (route.path === '/projects' && link.section === 'work') ? 'location' : undefined"
              @click="closeMenu"
            >
              {{ link.label }}
            </NuxtLink>
          </li>
        </ul>
      </nav>
    </div>
  </header>
</template>
