<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    /**
     * Display a listing of the categories.
     *
     * @return \Illuminate\Http\Response
     */
    public function getAllCategories()
    {
        return Category::all();
    }
    /**
     * Display a listing of the categories.
     *
     * @return \Illuminate\Http\Response
     */
    public function getCategories()
    {
        return Category::whereNull('parent_id')->get();
    }

    /**
     * Display a listing of the sub categories.
     *
     * @return \Illuminate\Http\Response
     */
    public function getSubCategories($parent_id)
    {
        return Category::where('parent_id', $parent_id)->get();
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
