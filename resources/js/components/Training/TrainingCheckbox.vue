<template>
    <label class="inline-flex items-center">
        <input
            type="checkbox"
            class="form-checkbox h-5 w-5 text-gray-600"
            :checked="checked"
            :disabled="isDisabled"
            @input="$emit('update:modelValue', $event.target.checked)"
        >
    </label>
</template>

<script>
export default {
    name: 'TrainingCheckbox',
    props: {
        modelValue: {
            type: Boolean,
            default: false,
            required: true
        },
        disabled: {
            type: Boolean,
            default: false,
            required: false
        }
    },
    data() {
        return {
            checked: this.modelValue,
            isDisabled: this.disabled
        }
    },
    watch: {
        modelValue: function (newVal) {
            this.checked = newVal
        },
        disabled: function(newVal) {
            this.isDisabled = newVal;
        }
    },
}
</script>

<style scoped>

.content:hover input ~ .checkmark {
  background-color: #a0aec0;
}

.content input:checked ~ .checkmark {
  background-color: #0078d4;
}

.checkmark:after {
  content: "";
  position: absolute;
  display: none;
}

.content input:checked ~ .checkmark:after {
  display: block;
}

.content .checkmark:after {
  left: 9px;
  top: 6px;
  width: 5px;
  height: 10px;
  border: solid white;
  border-width: 0 3px 3px 0;
  -webkit-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  transform: rotate(45deg);
}
</style>
