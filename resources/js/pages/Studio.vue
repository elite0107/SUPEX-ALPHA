<template>
    <div id="studio" class="grid grid-cols-12 gap-4">
        <div
            class="content mx-4 py-4 my-auto col-start-1 col-span-12 sm:col-start-3 sm:col-span-8 md:col-start-4 md:col-span-6"
        >
            <section class="category-section grid grid-cols-5 gap-4 mb-4">
                <SupexDropdown
                    class="col-start-1 col-span-5 md:col-span-3"
                    placeholder="Sélectionner la matière"
                    :items="categories"
                    bind_label="category"
                    bind_value="id"
                    :hasError="error.category"
                    @selected="onCategorySelected"
                />
                <SupexDropdown
                    class="col-start-1 col-span-5 md:col-start-4 md:col-span-2"
                    placeholder="Sélectionner l’item"
                    :items="sub_categories"
                    bind_label="category"
                    bind_value="id"
                    :hasError="error.sub_category"
                    @selected="onSubCategorySelected"
                />
            </section>
            <section class="mode-section mb-4">
                <div class="flex items-center">
                    <div class="flex items-center mr-4">
                        <Switch
                            v-model="mode"
                            :class="mode ? 'bg-teal-900' : 'bg-teal-700'"
                            class="relative inline-flex flex-shrink-0 h-[24px] w-[48px] border-2 border-transparent rounded-full cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-opacity-75"
                        >
                            <span class="sr-only">Use setting</span>
                            <span
                                aria-hidden="true"
                                :class="mode ? 'translate-x-6' : 'translate-x-0'"
                                class="pointer-events-none inline-block h-[20px] w-[20px] rounded-full bg-white shadow-lg transform ring-0 transition ease-in-out duration-200"
                            />
                        </Switch>
                    </div>
                    <span class="font-medium text-gray-700" v-if="!mode">Switch to Open Question</span>
                    <span class="font-medium text-gray-700" v-else>Switch to Select Question</span>
                </div>
            </section>
            <section class="question-section mb-4">
                <SupexInput v-model="question" size="large" placeholder="Question" :hasError="error.question" v-if="!isSubmitting"/>
                <Skeletor class="w-full rounded h-12" v-else/>
            </section>
            <section class="select-answer-section" v-if="!mode">
                <div v-if="!isSubmitting">
                    <div
                        class="flex mb-4 w-full"
                        v-for="(ans, index) in select_answers"
                        :key="index"
                    >
                        <span class="block p-2 font-semibold text-lg">{{ ans.label }}</span>
                        <div class="grow grid grid-cols-5 gap-4">
                            <SupexInput
                                v-model="ans.answer"
                                class="col-span-5"
                                :hasError="error.select_answers && error.select_answers[index]"
                            />
                            <div class="col-span-5 flex items-center">
                                <span
                                    class="block w-2 h-8 rounded-lg ml-6 mr-3 bg-gray-400"
                                ></span>
                                <SupexInput v-model="ans.description" class="grow"/>
                            </div>
                        </div>
                        <SupexCheckbox class="mx-2" v-model="ans.isTrue" />
                    </div>
                </div>
                <div v-else>
                    <div
                        class="flex mb-4 w-full"
                        v-for="(ans, index) in select_answers"
                        :key="index"
                    >
                        <span class="block p-2 font-semibold text-lg">{{ ans.label }}</span>
                        <div class="grow grid grid-cols-5 gap-4">
                            <Skeletor class="col-span-5 rounded h-12"/>
                            <div class="col-span-5 flex items-center">
                                <span
                                    class="block w-2 h-8 rounded-lg ml-6 mr-3 bg-gray-400"
                                ></span>
                                <Skeletor class="grow h-12 rounded" />
                            </div>
                        </div>
                        <Skeletor class="mx-12 w-12 h-12 rounded" />
                    </div>
                </div>
            </section>
            <section class="open-answer-section flex flex-col" v-else>
                <div class="flex items-center mb-4" v-if="!isSubmitting">
                    <span class="block w-2 h-8 bg-gray-400 rounded mx-4"></span>
                    <SupexInput
                        v-model="open_answer.answer"
                        class="w-full"
                        placeholder="Answer"
                        :hasError="error.open_answer && error.open_answer.answer"
                    />
                </div>
                <div class="flex flex-items-center mb-4" v-if="isSubmitting">
                    <Skeletor class="w-full h-12 rounded" />
                </div>
            </section>
            <span
                class="block text-red-500 text-base font-semibold mb-4"
                v-if="error.level"
            >Level Required</span>
            <section class="action-section flex justify-between flex-wrap w-full">
                <div class="flex justify-between sm:justify-start mb-4 grow">
                    <QuestionLevelButton
                        class="mr-2"
                        :selected="level === 'A'"
                        @click="onLevelClick('A')"
                    >A</QuestionLevelButton>

                    <QuestionLevelButton
                        class="mr-2"
                        :selected="level === 'B'"
                        @click="onLevelClick('B')"
                    >B</QuestionLevelButton>

                    <QuestionLevelButton
                        class="mr-2"
                        :selected="level === 'S'"
                        @click="onLevelClick('S')"
                    >S</QuestionLevelButton>
                </div>
                <button
                    class="h-12 w-full sm:w-48 bg-blue-600 rounded text-white mb-4 hover:bg-blue-800"
                    @click="onSubmit"
                >
                    Valider
                    <font-awesome-icon
                        :icon="{ prefix: 'fas', iconName: 'right-long' }"
                        class="ml-1"
                    />
                </button>
            </section>
        </div>
    </div>
</template>

<script>
// import Customized Supex Common UI Components
import SupexDropdown from "../components/Common/SupexDropdown.vue";
import SupexInput from "../components/Common/SupexInput.vue";
import SupexCheckbox from "../components/Common/SupexCheckbox.vue";

// import Customized Supex Studio UI Components
import QuestionLevelButton from "../components/Studio/QuestionLevelButton.vue";

// import Services
import ApiService from "../services/ApiService";

// import Helpers
import CommonHelper from '../helper/Common';

// import headlessui components
import { Switch } from '@headlessui/vue';

export default {
    name: "Studio",
    components: { SupexDropdown, SupexInput, SupexCheckbox, QuestionLevelButton, Switch },
    data() {
        return {
            categories: [],
            sub_categories: [],
            level: '',
            category: '',
            sub_category: '',
            question: "",
            mode: false,
            open_answer: {
                answer: '',
                description: '',
                isTrue: false
            },
            select_answers: [
                {
                    label: 'A',
                    answer: "",
                    description: "",
                    isTrue: false
                },
                {
                    label: 'B',
                    answer: "",
                    description: "",
                    isTrue: false
                },
                {
                    label: 'C',
                    answer: "",
                    description: "",
                    isTrue: false
                },
                {
                    label: 'D',
                    answer: "",
                    description: "",
                    isTrue: false
                },
                {
                    label: 'E',
                    answer: "",
                    description: "",
                    isTrue: false
                },
            ],
            error: {},
            isSubmitting: false
        }
    },
    mounted() {
        this.getCategories();
    },
    methods: {
        /**
         * Get list of categories
         */
        getCategories: function () {
            ApiService
                .getRequest('api/categories')
                .then(response => response.json())
                .then(response => {
                    this.categories = response;
                })
        },
        /**
         * Get list of sub categories
         */
        getSubCategories: function () {
            ApiService
                .getRequest(`api/sub_categories/${this.category}`)
                .then(response => response.json())
                .then(response => {
                    this.sub_categories = response;
                })
        },
        initialize: function () {
            this.level = '';
            this.question = '';
            this.mode = false;
            this.open_answer = {
                answer: '',
                description: '',
                isTrue: false
            };
            this.select_answers = [
                {
                    label: 'A',
                    answer: "",
                    description: "",
                    isTrue: false
                },
                {
                    label: 'B',
                    answer: "",
                    description: "",
                    isTrue: false
                },
                {
                    label: 'C',
                    answer: "",
                    description: "",
                    isTrue: false
                },
                {
                    label: 'D',
                    answer: "",
                    description: "",
                    isTrue: false
                },
                {
                    label: 'E',
                    answer: "",
                    description: "",
                    isTrue: false
                },
            ];
            this.error = {};
        },
        onLevelClick: function (level) {
            this.level = level;
        },
        onCategorySelected: function (event) {
            this.category = event;
            this.getSubCategories();
        },
        onSubCategorySelected: function (event) {
            this.sub_category = event;
        },
        onSubmit: function () {
            // Validate
            if (!this.isValid()) return;
            const payload = {
                category_id: this.category,
                subcategory_id: this.sub_category,
                question: this.question,
                level: this.level,
                mode: this.mode ? 'open' : 'select',
                answers: this.mode ? this.open_answer : this.select_answers
            }

            this.isSubmitting = true;
            ApiService
                .postRequest('api/questions', payload)
                .then(response => response.json())
                .then(() => {
                    this.initialize();
                    this.isSubmitting = false;
                })
        },
        isValid: function () {
            // Format Error
            this.error = {};

            // Validate Individuals
            if (CommonHelper.isEmpty(this.category)) this.error['category'] = true;
            if (CommonHelper.isEmpty(this.sub_category)) this.error['sub_category'] = true;
            if (CommonHelper.isEmpty(this.question)) this.error['question'] = true;
            if (CommonHelper.isEmpty(this.level)) this.error['level'] = true;

            // Validate Answers
            let answers = {};

            if (this.mode === false) {
                for (var i = 0; i < 5; i++) {
                    const answer = this.select_answers[i];
                    if (CommonHelper.isEmpty(answer.answer)) answers[i] = true;
                }

                if (Object.keys(answers).length !== 0) this.error['select_answers'] = answers;
            } else {
                if (CommonHelper.isEmpty(this.open_answer.answer)) answers.answer = true;

                if (Object.keys(answers).length !== 0) this.error['open_answer'] = answers;
            }

            // Validate total
            if (Object.keys(this.error).length !== 0) return false;
            return true;
        }
    }
}
</script>

<style scoped>
div#studio {
    height: 100vh;
    max-height: 100vh;
    overflow: auto;
}
</style>
