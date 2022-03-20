<template>
    <button
        class="submit-btn py-4 rounded-lg"
        @click="$emit('btnClicked')"
    >
        <slot />
    </button>
</template>

<script>
export default {
    name: 'SubmitButton'
}
</script>

<style scoped>
    .submit-btn {
        background: linear-gradient(180deg, rgba(238, 20, 125, 0.74) 0%, rgba(238, 20, 125, 0.39) 0.01%, rgba(238, 20, 125, 0.88) 100%);
        color: white;
        font-weight: 500;
        transition: all .1s;
    }

    .submit-btn:hover {
        background:
            linear-gradient(180deg,
                rgba(180, 0, 87, 0.87) 0%,
                rgba(180, 0, 87, 0.39) 0.01%,
                rgba(180, 0, 87, 0.88) 100%
            );
        transition: all .1s;
    }
</style>
