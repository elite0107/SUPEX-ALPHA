<template>
  <button
    class="w-12 h-12 text-center bg-gray-200 hover:bg-gray-300 font-semibold text-lg rounded"
    :class="{'bg-zinc-800 text-white': selected}"
    @click="onButtonClick"
  >
    <slot />
  </button>
</template>

<script>
export default {
  name: 'QuestionLevelButton',
  props: {
    selected: {
      type: Boolean,
      required: false,
      default: false
    }
  },
  methods: {
    onButtonClick: function() {
      this.$emit('click');
    }
  }
}
</script>