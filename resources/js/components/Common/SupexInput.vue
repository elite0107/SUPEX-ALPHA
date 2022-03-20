<template>
    <div
        class="w-full rounded border border-gray-250 h-12 outline-0 px-4 flex items-center bg-white"
        :class="{ 'border-red-500': hasError }"
    >
        <input
            class="w-full outline-0"
            :class="{ 'font-size-base': size === 'base', 'font-size-large': size === 'large' }"
            :value="modelValue"
            :placeholder="placeholder"
            @input="$emit('update:modelValue', $event.target.value)"
        />
    </div>
</template>

<script>
export default {
    name: 'SupexInput',
    props: {
        size: {
            type: String,
            default: "base"
        },
        modelValue: {
            type: String,
            default: '',
            required: true
        },
        hasError: {
            type: Boolean,
            default: false,
            required: false
        },
        placeholder: {
            type: String,
            default: '',
            required:false
        }
    },

}
</script>

<style scoped>
.font-size-base {
    font-size: 1rem;
    font-weight: 400;
}

.font-size-large {
    font-size: 1.25rem;
    font-weight: 600;
}
</style>
