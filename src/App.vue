<script setup>
import clouds from './components/clouds.vue'
import cat from './components/cat.vue'
import Bubble from "@/components/bubble.vue";
</script>

<template>
  <div class="wrapper"><div>
    <bubble />
    <cat />
  </div></div>
  <clouds />
</template>

<style scoped>
.wrapper {
  position: relative;
  z-index: 1000;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>