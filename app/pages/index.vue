<script setup>
import { portfolioData } from '~/data/portfolio.js';

const { data, pending, error } = await usePortfolioData();
const content = computed(() => data.value || portfolioData);
const featuredProjects = computed(() => content.value.projects.filter((project) => project.featured).slice(0, 3));

useSeoMeta({
  title: 'Hafizh Maulana Yusuf | Developer Portfolio',
  description: 'Explore the projects, skills, and learning journey of Hafizh Maulana Yusuf, a software development student.',
  ogTitle: 'Hafizh Maulana Yusuf | Developer Portfolio',
  ogDescription: 'A personal portfolio of web projects and software development learning.',
  ogType: 'website',
});
</script>

<template>
  <main id="main-content" class="page-main">
    <p v-if="error" class="container status-message" role="alert">
      Online portfolio data could not be loaded. Showing the saved project and skill details instead.
    </p>

    <section id="home" class="hero container" aria-labelledby="hero-title">
      <div class="hero-grid">
        <div class="hero-copy">
          <p class="hero-greeting">Hello, I'm</p>
          <h1 id="hero-title">{{ content.profile.name }}</h1>
          <p class="hero-role">{{ content.profile.role }}</p>
          <p class="hero-description">{{ content.profile.introduction }}</p>
          <div class="hero-actions">
            <NuxtLink class="button" to="/#work">View my work</NuxtLink>
            <a class="button button-secondary" :href="`mailto:${content.profile.email}`">Contact me</a>
          </div>
        </div>

        <figure class="hero-portrait-wrap">
          <div class="hero-portrait-frame">
            <img
              class="hero-portrait"
              :src="content.profile.portrait"
              :alt="content.profile.portraitAlt"
              width="720"
              height="1280"
              fetchpriority="high"
              decoding="async"
            >
          </div>
          <figcaption class="portrait-caption">
            <span>{{ content.profile.location }}</span>
            <span>Software development student</span>
          </figcaption>
        </figure>
      </div>
    </section>

    <section id="about" class="section section-soft" aria-labelledby="about-title">
      <div class="container about-grid">
        <img
          class="about-photo"
          :src="content.profile.aboutImage"
          :alt="content.profile.aboutImageAlt"
          width="780"
          height="1040"
          loading="lazy"
          decoding="async"
        >
        <div class="about-copy">
          <div class="section-heading">
            <p class="section-kicker">A little about me</p>
            <h2 id="about-title">About me</h2>
          </div>
          <h3>I learn by building.</h3>
          <p>{{ content.profile.about }}</p>
          <div class="about-note">
            <strong>What I'm learning now</strong>
            <p>{{ content.profile.currentFocus }}</p>
          </div>
        </div>
      </div>
    </section>

    <section id="skills" class="section" aria-labelledby="skills-title">
      <div class="container">
        <div class="skills-layout">
          <div class="skills-intro">
            <div class="section-heading">
              <p class="section-kicker">Tools I use</p>
              <h2 id="skills-title">Skills and technologies</h2>
            </div>
            <p>A working list of technologies explored through study and project work. No proficiency scores, just the tools behind the work.</p>
          </div>
          <div>
            <p v-if="pending" role="status" class="status-message">Loading skills...</p>
            <div v-else-if="!content.skills.length" class="empty-state">
              <h3>No skills have been added yet.</h3>
              <p>Add verified technologies to the portfolio data to show them here.</p>
            </div>
            <ul v-else class="skills-list" aria-label="Technology skills">
              <li v-for="skill in content.skills" :key="skill.name" class="skill-item">
                <TechIcon :name="skill.icon" :label="skill.name" />
                <span>{{ skill.name }}</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <section id="work" class="section section-soft" aria-labelledby="work-title">
      <div class="container">
        <div class="selected-work-head">
          <div class="section-heading">
            <p class="section-kicker">Selected work</p>
            <h2 id="work-title">Projects I've built</h2>
            <p>A few projects from coursework and independent practice.</p>
          </div>
          <NuxtLink class="text-link" to="/projects">View all projects</NuxtLink>
        </div>

        <p v-if="pending" role="status" class="status-message">Loading projects...</p>
        <div v-else-if="!featuredProjects.length" class="empty-state">
          <h3>No featured projects yet.</h3>
          <p>Publish a verified project to add it to this section.</p>
        </div>
        <div v-else class="project-grid">
          <ProjectCard v-for="project in featuredProjects" :key="project.id" :project="project" />
        </div>
      </div>
    </section>

    <section id="experience" class="section" aria-labelledby="experience-title">
      <div class="container">
        <div class="section-heading">
          <p class="section-kicker">Learning through practice</p>
          <h2 id="experience-title">Experience</h2>
          <p>My current path is shaped by study, coursework, and building projects.</p>
        </div>
        <div class="experience-list">
          <article v-for="item in content.experience" :key="item.title" class="experience-item">
            <h3>{{ item.title }}</h3>
            <p><strong>{{ item.organization }}</strong></p>
            <p>{{ item.description }}</p>
          </article>
        </div>
      </div>
    </section>

    <section id="process" class="section section-soft" aria-labelledby="process-title">
      <div class="container">
        <div class="section-heading">
          <p class="section-kicker">How I approach a project</p>
          <h2 id="process-title">My process</h2>
          <p>A practical sequence from understanding the problem to improving the result.</p>
        </div>
        <ol class="process-list">
          <li v-for="(step, index) in content.process" :key="step.name" class="process-item">
            <span class="process-number">{{ String(index + 1).padStart(2, '0') }}</span>
            <h3>{{ step.name }}</h3>
            <p>{{ step.description }}</p>
          </li>
        </ol>
      </div>
    </section>

    <section id="contact" class="contact-section" aria-labelledby="contact-title">
      <div class="container contact-grid">
        <div class="contact-copy">
          <p class="section-kicker">Contact</p>
          <h2 id="contact-title">Have a project in mind?</h2>
          <p>I'm open to meeting people, exchanging ideas, and learning through collaborative work.</p>
        </div>
        <a class="contact-action" :href="`mailto:${content.profile.email}`">Email Hafizh</a>
      </div>
    </section>
  </main>
</template>
