<script setup>
defineProps({
  project: { type: Object, required: true },
});
</script>

<template>
  <article class="project-card">
    <div class="project-image-wrap">
      <img
        class="project-image"
        :src="project.thumbnail"
        :alt="project.imageAlt"
        :width="project.imageWidth || 1360"
        :height="project.imageHeight || 768"
        loading="lazy"
        decoding="async"
      >
    </div>
    <div class="project-card-body">
      <p class="project-category">{{ project.categoryLabel }}</p>
      <h3>{{ project.title }}</h3>
      <p class="project-description">{{ project.description }}</p>
      <ul class="project-tags" :aria-label="`${project.title} technologies`">
        <li v-for="technology in project.technologies" :key="technology">{{ technology }}</li>
      </ul>
      <div v-if="project.githubUrl || project.demoUrl" class="project-links">
        <a
          v-if="project.githubUrl"
          :href="project.githubUrl"
          target="_blank"
          rel="noopener noreferrer"
          :aria-label="`View ${project.title} source code on GitHub`"
        >
          Source code
        </a>
        <a
          v-if="project.demoUrl"
          :href="project.demoUrl"
          target="_blank"
          rel="noopener noreferrer"
          :aria-label="`Open ${project.title} live demo`"
        >
          Live demo
        </a>
      </div>
    </div>
  </article>
</template>
