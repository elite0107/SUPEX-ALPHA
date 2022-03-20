<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
    use HasFactory;

    protected $fillable = [
        'category_id',
        'subcategory_id',
        'question',
        'level',
        'completed',
        'mode'
    ];

    /**
     * Get the Category that owns the Question.
     */
    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }

    /**
     * Get the SubCategory that owns the Question.
     */
    public function subcategory()
    {
        return $this->belongsTo(Category::class, 'subcategory_id');
    }

    /**
     * Get the Answers for the Question.
     */
    public function answers()
    {
        return $this->hasMany(Answer::class);
    }
}
