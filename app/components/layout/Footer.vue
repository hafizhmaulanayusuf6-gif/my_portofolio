<script setup>
import { portfolioData } from '~/data/portfolio.js';

const currentYear = new Date().getFullYear();
</script>

<template>
  <footer class="site-footer">
    <div class="container footer-row">
      <NuxtLink class="wordmark footer-wordmark" to="/#home">Hafizh<span>.</span></NuxtLink>
      <p>© {{ currentYear }} {{ portfolioData.profile.name }}</p>
      <nav class="footer-socials" aria-label="Social profiles">
        <a
          v-for="link in portfolioData.profile.links"
          :key="link.label"
          :href="link.href"
          target="_blank"
          rel="noopener noreferrer"
        >
          {{ link.label }}
        </a>
        <NuxtLink to="/projects">Projects</NuxtLink>
      </nav>
    </div>
  </footer>
</template>
