<template>
    <div class="absolute -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2 flex flex-col">
        <button
            class="btn-studio my-1 px-8 py-2 text-3xl rounded-2xl sm:px-16 sm:py-4 sm:text-5xl sm:rounded-3xl"
            @click="onClickStudioMode"
        >Créer des QCMs</button>

        <button
            class="btn-training my-1 px-8 py-2 text-3xl rounded-2xl sm:px-16 sm:py-4 sm:text-5xl sm:rounded-3xl"
            @click="onClickTrainingMode"
        >S’entraîner</button>
    </div>
</template>

<script>
export default {
    name: 'Home',
    methods: {
        onClickStudioMode: function () {
            this.$router.push('/studio');
        },
        onClickTrainingMode: function () {
            this.$router.push('/question-generator');
        }
    }
}
</script>

<style scoped>
button {
    font-style: normal;
    font-weight: normal;
}

button.btn-studio {
    background: #ffffff;
    border: 0.25rem solid #2b6de6;
    color: #2b6de6;
}

button.btn-studio:hover {
    background: #1f5dcf;
    border: 0.25rem solid #1f5dcf;
    color: white;
    transition: all .1s;
}

button.btn-training {
    background: rgb(238, 20, 125);
    border: 0.25rem solid rgb(238, 20, 125);
    color: #ffffff;
}

button.btn-training:hover {
    background: white;
    color: rgb(238, 20, 125);
    border: 0.25rem solid rgb(238, 20, 125);
    transition: all .1s;
}
</style>
