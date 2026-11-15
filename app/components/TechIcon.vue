<script setup>
import {
  siBootstrap,
  siCss,
  siDart,
  siFigma,
  siFlutter,
  siGit,
  siGithub,
  siHtml5,
  siJavascript,
  siLaravel,
  siMysql,
  siNodedotjs,
  siPhp,
  siWeb3dotjs,
} from 'simple-icons';

const props = defineProps({
  name: { type: String, default: '' },
  label: { type: String, required: true },
});

const icons = {
  bootstrap: siBootstrap,
  css3: siCss,
  dart: siDart,
  figma: siFigma,
  flutter: siFlutter,
  git: siGit,
  github: siGithub,
  html5: siHtml5,
  javascript: siJavascript,
  laravel: siLaravel,
  mysql: siMysql,
  nodedotjs: siNodedotjs,
  php: siPhp,
  web3dotjs: siWeb3dotjs,
};

const icon = computed(() => icons[props.name]);
</script>

<template>
  <svg v-if="icon" class="tech-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false">
    <path :d="icon.path" fill="currentColor" />
  </svg>
</template>
