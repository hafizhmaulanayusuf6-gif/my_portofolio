<script setup>
import { portfolioData, projectCategories } from '~/data/portfolio.js';

const { data, pending, error } = await usePortfolioData();
const content = computed(() => data.value || portfolioData);
const activeCategory = ref('all');
const filters = computed(() => [
  projectCategories[0],
  ...projectCategories.slice(1).filter((category) => content.value.projects.some((project) => project.category === category.id)),
]);
const filteredProjects = computed(() => {
  if (activeCategory.value === 'all') return content.value.projects;
  return content.value.projects.filter((project) => project.category === activeCategory.value);
});

useSeoMeta({
  title: 'My Projects | Hafizh Maulana Yusuf',
  description: 'A collection of web projects built by Hafizh Maulana Yusuf.',
  ogTitle: 'My Projects | Hafizh Maulana Yusuf',
  ogDescription: 'A collection of web projects built by Hafizh Maulana Yusuf.',
  ogType: 'website',
});
</script>

<template>
  <main id="main-content" class="page-main">
    <section class="container projects-intro" aria-labelledby="projects-title">
      <p class="section-kicker">Project archive</p>
      <h1 id="projects-title">My Projects</h1>
      <p>A collection of projects I've built, explored, and developed.</p>
    </section>

    <section class="container projects-results" aria-label="Project collection">
      <h2 class="visually-hidden">Project list</h2>
      <p v-if="error" class="status-message" role="alert">
        Online portfolio data could not be loaded. Showing the saved project details instead.
      </p>

      <div class="project-filters" role="group" aria-label="Filter projects by type">
        <button
          v-for="filter in filters"
          :key="filter.id"
          class="filter-button"
          type="button"
          :aria-pressed="activeCategory === filter.id"
          @click="activeCategory = filter.id"
        >
          {{ filter.label }}
        </button>
      </div>

      <p v-if="pending" role="status" class="status-message">Loading projects...</p>
      <div v-else-if="!filteredProjects.length" class="empty-state" role="status">
        <h2>No projects in this category yet.</h2>
        <p>Choose another project type or return to all projects.</p>
      </div>
      <div v-else class="project-grid" aria-live="polite" aria-atomic="false">
        <ProjectCard v-for="project in filteredProjects" :key="project.id" :project="project" />
      </div>
    </section>
  </main>
</template>
