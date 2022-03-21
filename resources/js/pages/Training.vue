<template>
    <div id="training" class="grid grid-cols-12 gap-4">
        <div
            class="content mx-4 py-4 my-auto col-start-1 col-span-12 sm:col-start-2 sm:col-span-10 md:col-start-3 md:col-span-8"
        >
            <div class="grid grid-cols-4 gap-4">
                <div class="col-start-1 col-span-3 responsive-height" v-if="!isLoading && questions[current].mode === 'select'">
                    <div class="question flex flex-col">
                        <p class="title mb-4">Item {{current + 1}} - {{category_name}}, <span class="sub_category">{{subcategory_name}}</span></p>
                        <div class="flex justify-between">
                            <span class="sub_title mb-4">{{questions[current].question}}</span>
                            <span
                                v-if="isFinished"
                                class="mark"
                                :class="{'green': getMark() == 1, 'orange': getMark() == 0.5 || getMark() === 0.2, 'red': getMark() == 0 }"
                            >{{getMark()}}/1</span>
                        </div>
                        <div
                            class="answer mb-3"
                            v-for="(answer, index) in randomAnswers"
                            :key="index"
                        >
                            <div
                                class="top flex flex-row items-center justify-between py-2 px-6"
                                :class="{'bg-gradient-green': isFinished && answer.isCorrect, 'bg-gradient-red line-through': isFinished && !answer.isCorrect}"
                            >
                                <span class="flex items-center">
                                    <TrainingCheckbox v-model="currentAnswer[answer.id]" class="mr-4" :disabled="isFinished"/>
                                    Proposition {{['A', 'B', 'C', 'D', 'E'][index]}}
                                </span>
                                <span
                                    class="expand-icon flex items-center justify-center"
                                    v-if="answer.description && isFinished"
                                    @click="onExpand(index)"
                                >
                                    <font-awesome-icon
                                        :icon="{prefix: 'fas', iconName: 'plus'}"
                                        v-if="open !== index"
                                    />
                                    <font-awesome-icon
                                        :icon="{prefix: 'fas', iconName: 'minus'}"
                                        v-if="open === index"
                                    />
                                </span>
                            </div>
                            <div class="bottom py-2 px-6">
                                <span :class="{'font-bold': isFinished && !isCorrect(answer.id)}">{{answer.answer}}</span>
                                <span class="description" v-if="answer.description && open === index">{{answer.description}}</span>
                            </div>
                        </div>
                        <div class="grid grid-cols-4">
                            <SubmitButton
                                class="col-start-1 col-span-4 md:col-start-2 md:col-span-2"
                                @btnClicked="onValider"
                            >
                                <span v-if="!isFinished">Valider</span>
                                <span v-if="isFinished">Next</span>
                            </SubmitButton>
                        </div>
                    </div>
                </div>
                <div class="col-start-1 col-span-3 responsive-height" v-else-if="!isLoading && questions[current].mode === 'open'">
                    <div class="question flex flex-col">
                        <div class="answer mb-3">
                            <p class="title mb-4">Item {{current + 1}} - {{category_name}}, <span class="sub_category">{{subcategory_name}}</span></p>
                            <div class="flex justify-between">
                                <span class="sub_title mb-4">{{questions[current].question}}</span>
                            </div>
                            <div class="flex flex-col border-2 border-gray-400 rounded">
                                <SupexInput v-model="currentAnswer.answer" v-if="!isFinished"/>
                                <span
                                    v-if="isFinished"
                                    class="font-bold text-lg mb-4 px-4 pt-4"
                                >{{currentAnswer.answer}}</span>
                                <div class="flex flex-row px-4 pb-4" v-if="isFinished">
                                    <span
                                        class="block w-2 rounded-lg mx-4 bg-gray-400"
                                    ></span>
                                    <span class="italitc">{{questions[current].answers[0].answer}}</span>
                                </div>
                            </div>
                        </div>
                        <div class="grid grid-cols-4">
                            <SubmitButton
                                class="col-start-1 col-span-4 md:col-start-2 md:col-span-2"
                                @btnClicked="onValider"
                            >
                                <span v-if="!isFinished">Valider</span>
                                <span v-if="isFinished">Next</span>
                            </SubmitButton>
                        </div>
                    </div>
                </div>
                <div class="col-start-1 col-span-3 responsive-height" v-else>
                    <div class="question flex flex-col">
                        <span class="title mb-4">
                            <Skeletor width="100%" height="1.2rem" class="rounded"></Skeletor>
                        </span>
                        <div class="mb-4">
                            <span class="sub_title mb-4">
                                <Skeletor width="70%" height="1.2rem" class="rounded" style="margin: 0.3rem 0;"></Skeletor>
                            </span>
                        </div>
                        <div
                            class="answer mb-3"
                            v-for="(answer, index) in 5"
                            :key="index"
                        >
                            <div class="top py-2 px-6">
                                <span class="flex items-center blcok">
                                    <Skeletor size="20" class="mr-4 my-1 rounded"></Skeletor>
                                    <Skeletor pill width="70%" height="1rem" class="my-1"></Skeletor>
                                </span>
                            </div>
                            <div class="bottom py-2 px-6">
                                <Skeletor width="100%" height="1rem" class="my-1 rounded"></Skeletor>
                            </div>
                        </div>
                        <div class="grid grid-cols-4">
                            <SubmitButton
                                class="col-start-1 col-span-4 md:col-start-2 md:col-span-2"
                                disabled
                            >
                                Valider
                            </SubmitButton>
                        </div>
                    </div>
                </div>
                <div class="col-start-4 col-span-1 responsive-height">
                    <div class="list flex flex-col h-full">
                        <div class="header">
                            <p>Série personnalisée</p>
                            <div class="w-full flex justify-between"><span>Progression</span> <span>{{current + 1}} / {{settings.count}}</span></div>
                        </div>
                        <div class="body grow overflow-auto">
                            <div class="flex flex-col">
                                <div
                                    class="item flex flex-row items-center"
                                    :class="{'text-gray-500 font-bold': current === index}"
                                    v-for="(item, index) in settings.count"
                                    :key="index"
                                    @click="onSpecific(index)"
                                >
                                    <span
                                        class="circle block rounded-full"
                                        :class="{'bg-gray-700': current === index}"
                                    ></span>
                                    <span class="ml-4">Question {{index + 1}}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
// import vuex
import { mapGetters } from 'vuex';

// import services
import ApiService from '../services/ApiService';
import SubmitButton from '../components/QuestionGenerator/SubmitButton.vue';
import TrainingCheckbox from '../components/Training/TrainingCheckbox.vue';
import SupexInput from '../components/Common/SupexInput.vue';

export default {
    name: "Training",
    computed: {
        ...mapGetters([
            "getSettings"
        ]),
        category_name: {
            get() {
                const category = this.questions[this.current].category_id;
                const value = this.categories.find(cate => cate.id === category);
                if (value) {
                    return value.category;
                }
                return '';
            }
        },
        subcategory_name: {
            get() {
                const sub_category = this.questions[this.current].subcategory_id;
                const value = this.categories.find(cate => cate.id === sub_category);
                if (value) {
                    return value.category;
                }
                return '';
            }
        }
    },
    data() {
        return {
            categories: [],
            settings: {},
            questions: [{}],
            current: 0,
            category: "",
            sub_category: "",
            currentAnswer: {},
            isFinished: false,
            open: -1,
            randomAnswers: [],
            isLoading: false
        };
    },
    created() {
        window.addEventListener('beforeunload', this.leaving);
    },
    mounted() {
        this.settings = this.getSettings();
        if (Object.keys(this.settings).length === 0) {
            this.$router.push('/question-generator');
        }

        this.isLoading = true;
        Promise.all([
            this.getQuestions(), this.getCategories()
        ]).then(result => {
            this.questions = result[0];
            this.categories = result[1];
            this.onSpecific(0);
            this.isLoading = false;
        })
    },
    methods: {
        leaving: function(event) {
            event.returnValue = "abc";
        },
        getCategories: async function() {
            return await ApiService.getRequest('api/categories/all').then(response => response.json());
        },
        getQuestions: async function () {
            return await ApiService.postRequest("api/questions/filtered", this.settings).then(response => response.json());
        },
        onValider: function() {
            if (!this.isFinished) {
                this.isFinished = true;
                if (this.questions[this.current].completed == false) this.setCompleted();
            } else {
                this.isFinished = false;
                this.onSpecific(this.current + 1);
            }
        },
        setCompleted: function() {
            const id = this.questions[this.current].id;
            ApiService
                .getRequest(`api/questions/complete/${id}`)
                .then(response => response.json())
                .then(response => console.log(response))
        },
        onSpecific: function(index) {
            if (index >= this.settings.count) {
                return;
            }
            this.isLoading = true;
            this.current = index;
            this.isFinished = false;
            this.currentAnswer = {};
            // TODO: Make Random
            if (this.questions[this.current].mode === 'select') {
                this.makeRandomAnswers();
            }
            this.isLoading = false;
        },
        makeRandomAnswers: function() {
            this.randomAnswers = [];
            const answers = this.questions[this.current].answers;
            while(this.randomAnswers.length < 5) {
                const randIndex = Math.floor(Math.random() * 1000) % 5;
                if (!this.isContain(this.randomAnswers, answers[randIndex])) {
                    this.randomAnswers.push(answers[randIndex]);
                    this.currentAnswer[answers[randIndex].id] = false;
                }
            }
        },
        isContain: function(items, item) {
            return !!items.find(element => element.id === item.id);
        },
        onExpand: function(index) {
            if (this.open === index) {
                this.open = -1;
            } else {
                this.open = index;
            }
        },
        isCorrect(id) {
            if (this.questions[this.current].mode === 'select') {
                const temp = this.questions[this.current].answers.find(ans => ans.id === id);
                if (this.currentAnswer[id] == temp.isCorrect) {
                    return true;
                }
                return false;
            } else {
                if (this.currentAnswer.answer === this.questions[this.current].answers[0].answer) {
                    return true;
                }
                return false;
            }
        },
        getMark() {
            var incorrect_cnt = 0;
            for(var i = 0 ; i < 5 ; i ++) {
                const answer = this.questions[this.current].answers[i];
                if (this.currentAnswer[answer.id] != answer.isCorrect) {
                    incorrect_cnt ++ ;
                }
            }
            switch (incorrect_cnt) {
                case 0:
                    return 1;
                case 1:
                    return 0.5;
                case 2:
                    return 0.2;
                default:
                    return 0;
            }
        },
        getCategoryName(id) {
            const value = this.categories.find(cate => cate.id === id);
            if (value) {
                return value.category;
            }
            return '';
        }
    },
    components: { SubmitButton, TrainingCheckbox, SupexInput }
}
</script>

<style scoped>
    div#training {
        height: 100vh;
        max-height: 100vh;
        overflow: auto;
    }

    div#training div.header {
        padding: 1.5rem 1rem 1rem 1rem;
        background: #2367E9;
        margin-bottom: 1rem;
        border-top-left-radius: 1rem;
        border-top-right-radius: 1rem;
    }

    div#training div.header p,
    div#training div.header div {
        font-size: 1rem;
        color: white;
    }
    div#training div.header p {
        font-weight: bold;
    }

    div.list {
        background: white;
        border-radius: 1rem;
    }

    div.list div.body div.item {
        padding: 0.8rem 1.2rem;
        color: #C4C4C4;
    }

    div.list div.body div.item:hover {
        cursor: pointer;
    }

    div.list div.body div.item span.circle {
        background: #C4C4C4;
        width: 1rem;
        height: 1rem;
    }

    div.question {
        background: white;
        border-radius: 1rem;
        padding: 1rem 1.5rem;
    }

    div.question p.title {
        font-weight: 500;
        font-size: 1.2rem;
    }

    div.question p.title span.sub_category {
        color: #EE147D;
    }

    div.question span.sub_title {
        font-weight: 600;
        font-size: 1.2rem;
        color: black;
    }

    div.question div.answer div.top {
        background: linear-gradient(180deg, rgba(196, 196, 196, 0.2263) 0%, rgba(228, 228, 228, 0.31) 100%);
        border: 1px solid #C4C4C4;
        border-top-left-radius: 0.5rem;
        border-top-right-radius: 0.5rem;
        font-weight: 500;
    }

    div.question div.answer div.bottom {
        border-left: 1px solid #C4C4C4;
        border-right: 1px solid #C4C4C4;
        border-bottom: 1px solid #C4C4C4;
        background: white;
        border-bottom-left-radius: 0.5rem;
        border-bottom-right-radius: 0.5rem;
    }

    .bg-gradient-green {
        background: linear-gradient(180deg, rgba(30, 255, 79, 0.67) 0%, rgba(25, 237, 148, 0.4757) 100%) !important;
    }

    .bg-gradient-red {
        background: linear-gradient(180deg, #FE4949 0%, rgba(255, 19, 62, 0.76) 100%) !important;
    }

    span.mark {
        font-size: 1rem;
        font-weight: 600;
    }

    .green { color: rgba(184, 233, 148, 0.67) !important; }
    .orange { color: #F5B67C !important; }
    .red { color: rgba(254, 69, 69, 0.72) !important; }

    span.expand-icon {
        width: 20px;
        height: 20px;
        border-radius: 100%;
        background: white;
        color: #C0C0C0;
    }

    span.expand-icon:hover { cursor: pointer; }

    span.description {
        display: block;
        margin-top: 1rem;
        padding: 0.1rem 0.5rem;
        border-left: 4px solid #999;
        font-style: italic;
    }

    .responsive-height {
        height: calc(100vh - 2rem);
    }
</style>
