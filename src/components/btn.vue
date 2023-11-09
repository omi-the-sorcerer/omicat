<script setup>
/* import font awesome icon component */
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faTwitter, faGithub } from '@fortawesome/free-brands-svg-icons'
library.add(faGithub)

defineProps({
  text: String,
  icon: String
})
</script>

<template>
  <button class="pulse" id="start">
    <font-awesome-icon icon='icon' />
    {{ text }}
  </button>
</template>

<style scoped>
@keyframes pulse {
  0% {
    box-shadow: 0 0 0 0 white;
  }
}
button.pulse {
  cursor: pointer;
  background: none;
  border: 2px solid;
  font: inherit;
  line-height: 1;
  margin: 0.5em;
  padding: 0.5em 1em;
  transition: 0.25s;
  /* width: 80%; */
  animation: pulse 1s infinite;
  box-shadow: 0 0 0 0.4em transparent;
  color: white;
  font-size: 30px;
}
button:hover {
  background-color: white;
  color: black;
  border-color:white;
}
</style>