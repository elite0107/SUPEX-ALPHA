<template>
    <div id="question-generator" class="grid grid-cols-12 gap-4">
        <div
            class="content mx-4 py-4 my-auto col-start-1 col-span-12 sm:col-start-3 sm:col-span-8 md:col-start-4 md:col-span-6"

        >
            <section class="category-section grid grid-cols-5 gap-4 mb-8">
                <SupexDropdown
                    class="col-start-1 col-span-5 md:col-span-3"
                    placeholder="Sélectionner la matière"
                    :items="categories"
                    bind_label="category"
                    bind_value="id"
                    :hasError="error.category"
                    :selected="category"
                    @selected="onCategorySelected"
                />
                <SupexDropdown
                    class="col-start-1 col-span-5 md:col-start-4 md:col-span-2"
                    placeholder="Sélectionner l’item"
                    :items="sub_categories"
                    bind_label="category"
                    bind_value="id"
                    :hasError="error.sub_category"
                    :selected="sub_category"
                    @selected="onSubCategorySelected"
                />
            </section>
            <section class="level-section grid grid-cols-3 gap-4 mb-8">
                <span class="col-span-3 font-bold">
                    NIVEAU
                </span>
                <QuestionGeneratorButton
                    class="col-span-3 sm:col-span-1"
                    :selected="isSelected('A')"
                    @btnClicked="onSetLevel('A')"
                >A</QuestionGeneratorButton>

                <QuestionGeneratorButton
                    class="col-span-3 sm:col-span-1"
                    :selected="isSelected('B')"
                    @btnClicked="onSetLevel('B')"
                >B</QuestionGeneratorButton>

                <QuestionGeneratorButton
                    class="col-span-3 sm:col-span-1"
                    :selected="isSelected('S')"
                    @btnClicked="onSetLevel('S')"
                >Indispensable</QuestionGeneratorButton>
            </section>
            <section class="question-section grid grid-cols-2 gap-4 mb-8">
                <span class="col-span-2 font-bold">
                    Type de questions
                </span>
                <QuestionGeneratorButton
                    class="col-span-2 sm:col-span-1"
                    :selected="isCompleteSelected(true)"
                    @btnClicked="onSetCompleted(true)"
                >Réalisées</QuestionGeneratorButton>
                <QuestionGeneratorButton
                    class="col-span-2 sm:col-span-1"
                    :selected="isCompleteSelected(false)"
                    @btnClicked="onSetCompleted(false)"
                >Non Réalisées</QuestionGeneratorButton>
            </section>
            <section class="count-section grid grid-cols-2 gap-x-8 gap-y-4 mb-8">
                <span class="col-span-2 font-bold">
                    Nombre de questions
                </span>
                <QuestionCountButton
                    class="col-span-2 sm:col-span-1"
                    @btnClicked="onAdjustQuestionCount"
                    :hasError="error.count"
                >
                    <!-- <span><b>{{count}}</b> sur {{total}}</span> -->
                    <div class="flex">
                        <input type="number" class="bg-transparent border border-transparent focus-visible:border-b-gray-500 mr-2 w-12 text-center outline-0 font_bold" v-model="count"/>
                        <span>sur {{total}}</span>
                    </div>
                </QuestionCountButton>
                <SubmitButton
                    class="col-span-2 sm:col-span-1"
                    @btnClicked="onSubmit"
                >
                    S’entraîner
                </SubmitButton>
            </section>
        </div>
        <!-- <div
            class="content mx-4 py-4 my-auto col-start-1 col-span-12 sm:col-start-3 sm:col-span-8 md:col-start-4 md:col-span-6"
            v-if="isLoading"
        >
            <section class="category-section grid grid-cols-5 gap-4 mb-8">
                <Skeletor class="h-12 col-start-1 col-span-5 md:col-span-3 rounded-lg" />
                <Skeletor class="h-12 col-start-1 col-span-5 md:col-start-4 md:col-span-2 rounded-lg" />
            </section>
            <section class="level-section grid grid-cols-3 gap-4 mb-8">
                <span class="col-span-3 font-bold">
                    NIVEAU
                </span>
                <Skeletor class="col-span-3 sm:col-span-1 rounded-lg" height="3.25rem" />
                <Skeletor class="col-span-3 sm:col-span-1 rounded-lg" height="3.25rem" />
                <Skeletor class="col-span-3 sm:col-span-1 rounded-lg" height="3.25rem" />
            </section>
            <section class="question-section grid grid-cols-2 gap-4 mb-8">
                <span class="col-span-2 font-bold">
                    Type de questions
                </span>
                <Skeletor class="col-span-2 sm:col-span-1 rounded-lg" height="3.25rem" />
                <Skeletor class="col-span-2 sm:col-span-1 rounded-lg" height="3.25rem" />
            </section>
            <section class="count-section grid grid-cols-2 gap-x-8 gap-y-4 mb-8">
                <span class="col-span-2 font-bold">
                    Nombre de questions
                </span>
                <Skeletor class="col-span-2 sm:col-span-1 rounded-lg" height="3.5rem" />
                <Skeletor class="col-span-2 sm:col-span-1 rounded-lg" height="3.5rem" />
            </section>
        </div> -->
    </div>
</template>

<script>
// import Customized Supex Common UI Components
import SupexDropdown from "../components/Common/SupexDropdown.vue";

// import Customized QuestionGenerator UI Comopnents
import QuestionGeneratorButton from "../components/QuestionGenerator/QuestionGeneratorButton.vue";
import QuestionCountButton from '../components/QuestionGenerator/QuestionCountButton.vue';
import SubmitButton from '../components/QuestionGenerator/SubmitButton.vue';

// import Services
import ApiService from "../services/ApiService";

// import vuex
import { mapMutations } from "vuex";

export default {
    name: 'QuestionGenerator',
    components: { SupexDropdown, QuestionGeneratorButton, QuestionCountButton, SubmitButton },
    data() {
        return {
            categories: [],
            sub_categories: [],
            category: '',
            sub_category: '',
            error: {},
            levels: [],
            completed: [],
            total: 0,
            count: 0,
            error: {},
            isLoading: false,
        }
    },
    mounted() {
        this.getCategories();
        this.getTotalQuestionCount();
    },
    methods: {
        ...mapMutations([
            'setSettings'
        ]),
        /**
         * Get list of categories
         */
        getCategories: function () {
            this.category = '';
            this.categories = [];
            this.isLoading = true;
            ApiService
                .getRequest('api/categories')
                .then(response => response.json())
                .then(response => { this.categories = response; this.isLoading = false; })
        },
        /**
         * Get list of sub categories
         */
        getSubCategories: function () {
            this.sub_category = '';
            this.sub_categories = [];
            this.isLoading = true;
            ApiService
                .getRequest(`api/sub_categories/${this.category}`)
                .then(response => response.json())
                .then(response => {
                    this.sub_categories = response;
                    this.getTotalQuestionCount();
                    this.isLoading = false;
                })
        },
        onCategorySelected: function (event) {
            this.category = event;
            this.getSubCategories();
        },
        onSubCategorySelected: function (event) {
            this.sub_category = event;
            this.getTotalQuestionCount();
        },
        getTotalQuestionCount: function () {
            this.isLoading = true;
            const payload = {
                category: this.category,
                sub_category: this.sub_category,
                level: this.levels,
                completed: this.completed
            };

            ApiService
                .postRequest('api/questions/total_count', payload)
                .then(response => response.json())
                .then(response => {
                    this.total = response.count;
                    if (this.count > this.total) this.count = 0;
                    this.isLoading = false;
                })
        },
        onSetLevel: function(level) {
            if (this.levels.indexOf(level) == -1) {
                this.levels.push(level);
            } else {
                this.levels = this.levels.filter(lev => lev != level);
            }
            this.getTotalQuestionCount();
        },
        onSetCompleted: function(val) {
            if (this.completed.indexOf(val) === -1) {
                this.completed.push(val);
            } else {
                this.completed = this.completed.filter(item => item != val);
            }
            this.getTotalQuestionCount();
        },
        onAdjustQuestionCount: function(mode) {
            switch (mode) {
                case 'minus':
                    if (this.count > 0) {
                        this.count --;
                    }
                    break;
                case 'plus':
                    if (this.count < this.total) {
                        this.count ++;
                    }
                    break;
                default:
                    break;
            }
        },
        isSelected: function(val) {
            return this.levels.indexOf(val) !== -1;
        },
        isCompleteSelected: function(val) {
            return this.completed.indexOf(val) !== -1;
        },
        isValid: function() {
            if (this.count <= 0 || this.count > this.total || this.count === '') {
                this.error.count = true;
            }

            if (Object.keys(this.error).length > 0) {
                return false;
            }
            return true;
        },
        onSubmit: function() {
            // Validate
            this.error = {};
            if (!this.isValid()) return;
            // Submit
            var payload = {
                category: this.category,
                sub_category: this.sub_category,
                count: this.count,
                level: this.levels,
                completed: this.completed,
            };

            this.setSettings(payload);
            this.$router.push('/training');
        }
    }
}
</script>

<style scoped>
    div#question-generator {
        max-height: 100vh;
        height: 100vh;
        overflow: auto;
    }
</style>
