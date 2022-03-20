<?php

namespace App\Http\Controllers;

use App\Models\Question;
use App\Models\Answer;
use Illuminate\Http\Request;

class QuestionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // Create Question
        $question = new Question;
        $question->category_id = $request->category_id;
        $question->subcategory_id = $request->subcategory_id;
        $question->question = $request->question;
        $question->level = $request->level;
        $question->mode = $request->mode;
        $question->save();
        // Create Answers
        if ($request->mode === 'open') {
            $answer = new Answer;
            $answer->question_id = $question->id;
            $answer->answer = $request->answers['answer'];
            $answer->description = $request->answers['description'];
            $answer->isCorrect = $request->answers['isTrue'];

            $answer->save();
        } else {
            foreach ($request->answers as $ans) {
            $answer = new Answer;
            $answer->question_id = $question->id;
            $answer->answer = $ans['answer'];
            $answer->description = $ans['description'];
            $answer->isCorrect = $ans['isTrue'];

            $answer->save();
        }
        }
        return $question;
    }

    /**
     * Fetch one by id.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function fetch($id)
    {
        return Question::with('Answers')->where('id', $id)->get();
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Question  $question
     * @return \Illuminate\Http\Response
     */
    public function show(Question $question)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Question  $question
     * @return \Illuminate\Http\Response
     */
    public function edit(Question $question)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Question  $question
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Question $question)
    {
        //
    }

    /**
     * Get All Question Count
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function totalCount(Request $request)
    {
        $payload = $request;

        // Get matching question ids
        $temp = Question::whereIn('completed', $payload->completed)
                        ->whereIn('level', $payload->level);

        if ($payload->category !== null) {
            $temp = $temp->where('category_id', $payload->category);
        }

        if($payload->sub_category !== null) {
            $temp = $temp->where('subcategory_id', $payload->sub_category);
        }

        return response()->json(['count' => $temp->count()], 200);
    }

    /**
     * Get Filtered Quesitons by request
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function getFiltered(Request $request) {
        $payload = $request;

        // Get matching question ids
        $temp = Question::whereIn('completed', $payload->completed)
                        ->whereIn('level', $payload->level);
        if ($payload->category !== null) {
            $temp = $temp->where('category_id', $payload->category);
        }

        if($payload->sub_category !== null) {
            $temp = $temp->where('subcategory_id', $payload->sub_category);
        }

        $id_list = $temp->pluck('id')->toArray();
        $random_ids = $this->makeRandomArray($id_list, $payload->count);
        return Question::with('Answers')->whereIn('id', $random_ids)->get();
    }

    public function complete($id) {
        $question = Question::find($id);
        $question->completed = true;
        $question->save();
        return $question;
    }

    /**
     * Get Random Id Array
     *
     * @param Array     $list
     * @param Integer   $count
     * @return Array
     */
    public function makeRandomArray($list, $count) {
        $random_list = array();
        $total_length = count($list);
        while (count($random_list) != $count) {
            $random_index = rand(1, 10000) % $total_length;
            if (!in_array($list[$random_index], $random_list)) {
                array_push($random_list, $list[$random_index]);
            }
        }

        return $random_list;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Question  $question
     * @return \Illuminate\Http\Response
     */
    public function destroy(Question $question)
    {
        //
    }
}
