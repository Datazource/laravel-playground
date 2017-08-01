<?php

namespace App\Repositories;

use App\Models\EloquentNodeVisitor;
use Xiag\Rql\Parser\Lexer;
use Xiag\Rql\Parser\Parser;

/**
 * Class BaseRepository.
 */
class BaseRepository
{
    public $query;
    public $sorty = [];
    /**
     * @return mixed
     */
    public function getAll()
    {
        return $this->query()->get();
    }

    /**
     * @return mixed
     */
    public function getCount()
    {
        return $this->query()->count();
    }

    /**
     * @param $id
     *
     * @return mixed
     */
    public function find($id)
    {
        return $this->query()->find($id);
    }

    /**
     * @return mixed
     */
    public function query()
    {
        return call_user_func(static::MODEL.'::query');
    }

    /**
     * Read query string for API
     * @param strings $request
     */
    public function read_query_string()
    {
        $this->parse_filter();
        $this->parse_sort();
        return true;
    }

    /**
     * Parse filter String from Query String
     * @param string $filter
     */
    public function parse_filter()
    {
        $lexer          = new Lexer();
        $parser         = new Parser();
        $filters        = request()->input('filter');

        $tokens         = $lexer->tokenize($filters);
        $rqlQuery       = $parser->parse($tokens);

        $nodeVisitor    = new EloquentNodeVisitor();
        $queryBuilder   = $this->getDataModel()->query();


        $nodeVisitor->visit($rqlQuery, $queryBuilder->getQuery());

        $this->query = $queryBuilder;
    }

    /**
     * Parse fields Array from Query String
     * @param array[] $fields
     */
    public function parse_fields()
    {
        return request()->input('fields');
    }

    /**
     * Parse include Strings from Query Strings
     * @param strings $include
     */
    public function parse_include()
    {
        return request()->input('include');
    }

    /**
     * Parse sort Strings from Query Strings
     * @param strings $sort
     * + ASC - DESC
     */
    public function parse_sort()
    {
        $sort = request()->input('sort');
        $sorting = null;

        if (!empty($sort) && is_string($sort)) {
            $members = \explode(',', $sort);
            if (!empty($members)) {
                foreach ($members as $field) {
                    $key = ltrim($field, '-');
                    $sorting = $this->addField($key, ('-' === $field[0]) ? 'desc' : 'asc');
                }
            }
        }

        foreach ( $this->sorty as $key => $value ) {
            $this->query->orderBy($key,$value);
        }
 
    }

    /**
     * @param string $field
     * @param string $direction
     */
    public function addField($field, $direction)
    {
        $this->sorty[(string) $field] = (string) $direction;
    }

    /**
     * Parse page.number int from Query Strings
     * @param int $number
     */
    public function parse_page_number()
    {
        return request()->input('page.number');
    }

    /**
     * Parse page.size int from Query Strings
     * @param int $size
     */
    public function parse_page_size()
    {
        return request()->input('page.size');
    }

    /**
     * Parse page.limit int from Query Strings
     * @param int $limit
     */
    public function parse_page_limit()
    {
        return request()->input('page.limit');
    }

    /**
     * Parse page.cursor int from Query Strings
     * @param int $cursor
     */
    public function parse_page_cursor()
    {
        return request()->input('page.cursor');
    }

    /**
     * Parse page.offset int from Query Strings
     * @param int $offset
     */
    public function parse_page_offset()
    {
        return request()->input('page.offset');
    }
}
