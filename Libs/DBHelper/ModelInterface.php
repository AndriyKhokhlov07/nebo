<?php

namespace Libs\DBHelper;

interface ModelInterface
{
    const CONDITION_LOGIC_AND = 'AND';
    const CONDITION_LOGIC_OR = 'OR';

    const CONDITION_OPERATOR_LIKE = 'LIKE';
    const CONDITION_OPERATOR_ILIKE = 'ILIKE';
    const CONDITION_OPERATOR_IN = 'IN';
    const CONDITION_OPERATOR_NOT_IN = 'NOT IN';
    const CONDITION_OPERATOR_IS_NULL = 'IS NULL';
    const CONDITION_OPERATOR_IS_NOT_NULL = 'IS NOT NULL';
}