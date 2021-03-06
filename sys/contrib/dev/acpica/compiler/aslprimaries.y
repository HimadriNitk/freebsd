NoEcho('
/******************************************************************************
 *
 * Module Name: aslprimaries.y - Rules for primary ASL operators
 *
 *****************************************************************************/

/*
 * Copyright (C) 2000 - 2016, Intel Corp.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions, and the following disclaimer,
 *    without modification.
 * 2. Redistributions in binary form must reproduce at minimum a disclaimer
 *    substantially similar to the "NO WARRANTY" disclaimer below
 *    ("Disclaimer") and any redistribution must be conditioned upon
 *    including a substantially similar Disclaimer requirement for further
 *    binary redistribution.
 * 3. Neither the names of the above-listed copyright holders nor the names
 *    of any contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * Alternatively, this software may be distributed under the terms of the
 * GNU General Public License ("GPL") version 2 as published by the Free
 * Software Foundation.
 *
 * NO WARRANTY
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGES.
 */

')


/*******************************************************************************
 *
 * ASL Primary Terms
 *
 ******************************************************************************/

AccessAsTerm
    : PARSEOP_ACCESSAS '('
        AccessTypeKeyword
        OptionalAccessAttribTerm
        ')'                         {$$ = TrCreateNode (PARSEOP_ACCESSAS,2,$3,$4);}
    | PARSEOP_ACCESSAS '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

AcquireTerm
    : PARSEOP_ACQUIRE '('           {$<n>$ = TrCreateLeafNode (PARSEOP_ACQUIRE);}
        SuperName
        ',' WordConstExpr
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$6);}
    | PARSEOP_ACQUIRE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

AddTerm
    : PARSEOP_ADD '('               {$<n>$ = TrCreateLeafNode (PARSEOP_ADD);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_ADD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

AliasTerm
    : PARSEOP_ALIAS '('             {$<n>$ = TrCreateLeafNode (PARSEOP_ALIAS);}
        NameString
        NameStringItem
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,
                                        TrSetNodeFlags ($5, NODE_IS_NAME_DECLARATION));}
    | PARSEOP_ALIAS '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

AndTerm
    : PARSEOP_AND '('               {$<n>$ = TrCreateLeafNode (PARSEOP_AND);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_AND '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ArgTerm
    : PARSEOP_ARG0                  {$$ = TrCreateLeafNode (PARSEOP_ARG0);}
    | PARSEOP_ARG1                  {$$ = TrCreateLeafNode (PARSEOP_ARG1);}
    | PARSEOP_ARG2                  {$$ = TrCreateLeafNode (PARSEOP_ARG2);}
    | PARSEOP_ARG3                  {$$ = TrCreateLeafNode (PARSEOP_ARG3);}
    | PARSEOP_ARG4                  {$$ = TrCreateLeafNode (PARSEOP_ARG4);}
    | PARSEOP_ARG5                  {$$ = TrCreateLeafNode (PARSEOP_ARG5);}
    | PARSEOP_ARG6                  {$$ = TrCreateLeafNode (PARSEOP_ARG6);}
    ;

BankFieldTerm
    : PARSEOP_BANKFIELD '('         {$<n>$ = TrCreateLeafNode (PARSEOP_BANKFIELD);}
        NameString
        NameStringItem
        TermArgItem
        ',' AccessTypeKeyword
        ',' LockRuleKeyword
        ',' UpdateRuleKeyword
        ')' '{'
            FieldUnitList '}'       {$$ = TrLinkChildren ($<n>3,7,
                                        $4,$5,$6,$8,$10,$12,$15);}
    | PARSEOP_BANKFIELD '('
        error ')' '{' error '}'     {$$ = AslDoError(); yyclearin;}
    ;

BreakTerm
    : PARSEOP_BREAK                 {$$ = TrCreateNode (PARSEOP_BREAK, 0);}
    ;

BreakPointTerm
    : PARSEOP_BREAKPOINT            {$$ = TrCreateNode (PARSEOP_BREAKPOINT, 0);}
    ;

BufferTerm
    : PARSEOP_BUFFER                {$<n>$ = TrCreateLeafNode (PARSEOP_BUFFER);}
        OptionalDataCount
        '{' BufferTermData '}'      {$$ = TrLinkChildren ($<n>2,2,$3,$5);}
    ;

BufferTermData
    : ByteList                      {}
    | StringData                    {}
    ;

CaseTerm
    : PARSEOP_CASE '('              {$<n>$ = TrCreateLeafNode (PARSEOP_CASE);}
        DataObject
        ')' '{'
            TermList '}'            {$$ = TrLinkChildren ($<n>3,2,$4,$7);}
    | PARSEOP_CASE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ConcatTerm
    : PARSEOP_CONCATENATE '('       {$<n>$ = TrCreateLeafNode (PARSEOP_CONCATENATE);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_CONCATENATE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ConcatResTerm
    : PARSEOP_CONCATENATERESTEMPLATE '(' {$<n>$ = TrCreateLeafNode (
                                            PARSEOP_CONCATENATERESTEMPLATE);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_CONCATENATERESTEMPLATE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ConnectionTerm
    : PARSEOP_CONNECTION '('
        NameString
        ')'                         {$$ = TrCreateNode (PARSEOP_CONNECTION,1,$3);}
    | PARSEOP_CONNECTION '('        {$<n>$ = TrCreateLeafNode (PARSEOP_CONNECTION);}
        ResourceMacroTerm
        ')'                         {$$ = TrLinkChildren ($<n>3, 1,
                                        TrLinkChildren (
                                            TrCreateLeafNode (PARSEOP_RESOURCETEMPLATE), 3,
                                            TrCreateLeafNode (PARSEOP_DEFAULT_ARG),
                                            TrCreateLeafNode (PARSEOP_DEFAULT_ARG),
                                            $4));}
    | PARSEOP_CONNECTION '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

CondRefOfTerm
    : PARSEOP_CONDREFOF '('         {$<n>$ = TrCreateLeafNode (PARSEOP_CONDREFOF);}
        SuperName
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_CONDREFOF '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ContinueTerm
    : PARSEOP_CONTINUE              {$$ = TrCreateNode (PARSEOP_CONTINUE, 0);}
    ;

CopyObjectTerm
    : PARSEOP_COPYOBJECT '('        {$<n>$ = TrCreateLeafNode (PARSEOP_COPYOBJECT);}
        TermArg
        ',' SimpleTarget
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,
                                        TrSetNodeFlags ($6, NODE_IS_TARGET));}
    | PARSEOP_COPYOBJECT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

CreateBitFieldTerm
    : PARSEOP_CREATEBITFIELD '('    {$<n>$ = TrCreateLeafNode (PARSEOP_CREATEBITFIELD);}
        TermArg
        TermArgItem
        NameStringItem
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,
                                        TrSetNodeFlags ($6, NODE_IS_NAME_DECLARATION));}
    | PARSEOP_CREATEBITFIELD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

CreateByteFieldTerm
    : PARSEOP_CREATEBYTEFIELD '('   {$<n>$ = TrCreateLeafNode (PARSEOP_CREATEBYTEFIELD);}
        TermArg
        TermArgItem
        NameStringItem
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,
                                        TrSetNodeFlags ($6, NODE_IS_NAME_DECLARATION));}
    | PARSEOP_CREATEBYTEFIELD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

CreateDWordFieldTerm
    : PARSEOP_CREATEDWORDFIELD '('  {$<n>$ = TrCreateLeafNode (PARSEOP_CREATEDWORDFIELD);}
        TermArg
        TermArgItem
        NameStringItem
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,
                                        TrSetNodeFlags ($6, NODE_IS_NAME_DECLARATION));}
    | PARSEOP_CREATEDWORDFIELD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

CreateFieldTerm
    : PARSEOP_CREATEFIELD '('       {$<n>$ = TrCreateLeafNode (PARSEOP_CREATEFIELD);}
        TermArg
        TermArgItem
        TermArgItem
        NameStringItem
        ')'                         {$$ = TrLinkChildren ($<n>3,4,$4,$5,$6,
                                        TrSetNodeFlags ($7, NODE_IS_NAME_DECLARATION));}
    | PARSEOP_CREATEFIELD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

CreateQWordFieldTerm
    : PARSEOP_CREATEQWORDFIELD '('  {$<n>$ = TrCreateLeafNode (PARSEOP_CREATEQWORDFIELD);}
        TermArg
        TermArgItem
        NameStringItem
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,
                                        TrSetNodeFlags ($6, NODE_IS_NAME_DECLARATION));}
    | PARSEOP_CREATEQWORDFIELD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

CreateWordFieldTerm
    : PARSEOP_CREATEWORDFIELD '('   {$<n>$ = TrCreateLeafNode (PARSEOP_CREATEWORDFIELD);}
        TermArg
        TermArgItem
        NameStringItem
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,
                                        TrSetNodeFlags ($6, NODE_IS_NAME_DECLARATION));}
    | PARSEOP_CREATEWORDFIELD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

DataRegionTerm
    : PARSEOP_DATATABLEREGION '('   {$<n>$ = TrCreateLeafNode (PARSEOP_DATATABLEREGION);}
        NameString
        TermArgItem
        TermArgItem
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,4,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),$5,$6,$7);}
    | PARSEOP_DATATABLEREGION '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

DebugTerm
    : PARSEOP_DEBUG                 {$$ = TrCreateLeafNode (PARSEOP_DEBUG);}
    ;

DecTerm
    : PARSEOP_DECREMENT '('         {$<n>$ = TrCreateLeafNode (PARSEOP_DECREMENT);}
        SuperName
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_DECREMENT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

DefaultTerm
    : PARSEOP_DEFAULT '{'           {$<n>$ = TrCreateLeafNode (PARSEOP_DEFAULT);}
        TermList '}'                {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_DEFAULT '{'
        error '}'                   {$$ = AslDoError(); yyclearin;}
    ;

DerefOfTerm
    : PARSEOP_DEREFOF '('           {$<n>$ = TrCreateLeafNode (PARSEOP_DEREFOF);}
        TermArg
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_DEREFOF '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

DeviceTerm
    : PARSEOP_DEVICE '('            {$<n>$ = TrCreateLeafNode (PARSEOP_DEVICE);}
        NameString
        ')' '{'
            TermList '}'            {$$ = TrLinkChildren ($<n>3,2,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),$7);}
    | PARSEOP_DEVICE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

DivideTerm
    : PARSEOP_DIVIDE '('            {$<n>$ = TrCreateLeafNode (PARSEOP_DIVIDE);}
        TermArg
        TermArgItem
        Target
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,4,$4,$5,$6,$7);}
    | PARSEOP_DIVIDE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

EISAIDTerm
    : PARSEOP_EISAID '('
        StringData ')'              {$$ = TrUpdateNode (PARSEOP_EISAID, $3);}
    | PARSEOP_EISAID '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ElseIfTerm
    : IfTerm ElseTerm               {$$ = TrLinkPeerNode ($1,$2);}
    ;

ElseTerm
    :                               {$$ = NULL;}
    | PARSEOP_ELSE '{'              {$<n>$ = TrCreateLeafNode (PARSEOP_ELSE);}
        TermList '}'                {$$ = TrLinkChildren ($<n>3,1,$4);}

    | PARSEOP_ELSE '{'
        error '}'                   {$$ = AslDoError(); yyclearin;}

    | PARSEOP_ELSE
        error                       {$$ = AslDoError(); yyclearin;}

    | PARSEOP_ELSEIF '('            {$<n>$ = TrCreateLeafNode (PARSEOP_ELSE);}
        TermArg                     {$<n>$ = TrCreateLeafNode (PARSEOP_IF);}
        ')' '{'
            TermList '}'            {TrLinkChildren ($<n>5,2,$4,$8);}
        ElseTerm                    {TrLinkPeerNode ($<n>5,$11);}
                                    {$$ = TrLinkChildren ($<n>3,1,$<n>5);}

    | PARSEOP_ELSEIF '('
        error ')'                   {$$ = AslDoError(); yyclearin;}

    | PARSEOP_ELSEIF
        error                       {$$ = AslDoError(); yyclearin;}
    ;

EventTerm
    : PARSEOP_EVENT '('             {$<n>$ = TrCreateLeafNode (PARSEOP_EVENT);}
        NameString
        ')'                         {$$ = TrLinkChildren ($<n>3,1,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION));}
    | PARSEOP_EVENT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ExternalTerm
    : PARSEOP_EXTERNAL '('
        NameString
        OptionalObjectTypeKeyword
        OptionalParameterTypePackage
        OptionalParameterTypesPackage
        ')'                         {$$ = TrCreateNode (PARSEOP_EXTERNAL,4,$3,$4,$5,$6);}
    | PARSEOP_EXTERNAL '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

FatalTerm
    : PARSEOP_FATAL '('             {$<n>$ = TrCreateLeafNode (PARSEOP_FATAL);}
        ByteConstExpr
        ',' DWordConstExpr
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$6,$7);}
    | PARSEOP_FATAL '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

FieldTerm
    : PARSEOP_FIELD '('             {$<n>$ = TrCreateLeafNode (PARSEOP_FIELD);}
        NameString
        ',' AccessTypeKeyword
        ',' LockRuleKeyword
        ',' UpdateRuleKeyword
        ')' '{'
            FieldUnitList '}'       {$$ = TrLinkChildren ($<n>3,5,$4,$6,$8,$10,$13);}
    | PARSEOP_FIELD '('
        error ')' '{' error '}'     {$$ = AslDoError(); yyclearin;}
    ;

FindSetLeftBitTerm
    : PARSEOP_FINDSETLEFTBIT '('    {$<n>$ = TrCreateLeafNode (PARSEOP_FINDSETLEFTBIT);}
        TermArg
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_FINDSETLEFTBIT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

FindSetRightBitTerm
    : PARSEOP_FINDSETRIGHTBIT '('   {$<n>$ = TrCreateLeafNode (PARSEOP_FINDSETRIGHTBIT);}
        TermArg
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_FINDSETRIGHTBIT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

    /* Convert a For() loop to a While() loop */
ForTerm
    : PARSEOP_FOR '('               {$<n>$ = TrCreateLeafNode (PARSEOP_WHILE);}
        OptionalTermArg ','         {}
        OptionalPredicate ','
        OptionalTermArg             {$<n>$ = TrLinkPeerNode ($4,$<n>3);
                                        TrSetParent ($9,$<n>3);}                /* New parent is WHILE */
        ')' '{' TermList '}'        {$<n>$ = TrLinkChildren ($<n>3,2,$7,$13);}
                                    {$<n>$ = TrLinkPeerNode ($13,$9);
                                        $$ = $<n>10;}
    ;

OptionalPredicate
    :                               {$$ = TrCreateValuedLeafNode (PARSEOP_INTEGER, 1);}
    | TermArg                       {$$ = $1;}
    ;

FprintfTerm
    : PARSEOP_FPRINTF '('            {$<n>$ = TrCreateLeafNode (PARSEOP_FPRINTF);}
        TermArg ','
        StringData
        PrintfArgList
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$6,$7);}
    | PARSEOP_FPRINTF '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

FromBCDTerm
    : PARSEOP_FROMBCD '('           {$<n>$ = TrCreateLeafNode (PARSEOP_FROMBCD);}
        TermArg
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_FROMBCD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

FunctionTerm
    : PARSEOP_FUNCTION '('          {$<n>$ = TrCreateLeafNode (PARSEOP_METHOD);}
        NameString
        OptionalParameterTypePackage
        OptionalParameterTypesPackage
        ')' '{'
            TermList '}'            {$$ = TrLinkChildren ($<n>3,7,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),
                                        TrCreateValuedLeafNode (PARSEOP_BYTECONST, 0),
                                        TrCreateLeafNode (PARSEOP_SERIALIZERULE_NOTSERIAL),
                                        TrCreateValuedLeafNode (PARSEOP_BYTECONST, 0),$5,$6,$9);}
    | PARSEOP_FUNCTION '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

IfTerm
    : PARSEOP_IF '('                {$<n>$ = TrCreateLeafNode (PARSEOP_IF);}
        TermArg
        ')' '{'
            TermList '}'            {$$ = TrLinkChildren ($<n>3,2,$4,$7);}

    | PARSEOP_IF '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

IncludeTerm
    : PARSEOP_INCLUDE '('
        String  ')'                 {$$ = TrUpdateNode (PARSEOP_INCLUDE, $3);
                                        FlOpenIncludeFile ($3);}
    ;

IncludeEndTerm
    : PARSEOP_INCLUDE_END           {$<n>$ = TrCreateLeafNode (PARSEOP_INCLUDE_END);
                                        TrSetCurrentFilename ($$);}
    ;

IncTerm
    : PARSEOP_INCREMENT '('         {$<n>$ = TrCreateLeafNode (PARSEOP_INCREMENT);}
        SuperName
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_INCREMENT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

IndexFieldTerm
    : PARSEOP_INDEXFIELD '('        {$<n>$ = TrCreateLeafNode (PARSEOP_INDEXFIELD);}
        NameString
        NameStringItem
        ',' AccessTypeKeyword
        ',' LockRuleKeyword
        ',' UpdateRuleKeyword
        ')' '{'
            FieldUnitList '}'       {$$ = TrLinkChildren ($<n>3,6,$4,$5,$7,$9,$11,$14);}
    | PARSEOP_INDEXFIELD '('
        error ')' '{' error '}'     {$$ = AslDoError(); yyclearin;}
    ;

IndexTerm
    : PARSEOP_INDEX '('             {$<n>$ = TrCreateLeafNode (PARSEOP_INDEX);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_INDEX '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LAndTerm
    : PARSEOP_LAND '('              {$<n>$ = TrCreateLeafNode (PARSEOP_LAND);}
        TermArg
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_LAND '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LEqualTerm
    : PARSEOP_LEQUAL '('            {$<n>$ = TrCreateLeafNode (PARSEOP_LEQUAL);}
        TermArg
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_LEQUAL '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LGreaterEqualTerm
    : PARSEOP_LGREATEREQUAL '('     {$<n>$ = TrCreateLeafNode (PARSEOP_LLESS);}
        TermArg
        TermArgItem
        ')'                         {$$ = TrCreateNode (PARSEOP_LNOT, 1,
                                        TrLinkChildren ($<n>3,2,$4,$5));}
    | PARSEOP_LGREATEREQUAL '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LGreaterTerm
    : PARSEOP_LGREATER '('          {$<n>$ = TrCreateLeafNode (PARSEOP_LGREATER);}
        TermArg
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_LGREATER '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LLessEqualTerm
    : PARSEOP_LLESSEQUAL '('        {$<n>$ = TrCreateLeafNode (PARSEOP_LGREATER);}
        TermArg
        TermArgItem
        ')'                         {$$ = TrCreateNode (PARSEOP_LNOT, 1,
                                        TrLinkChildren ($<n>3,2,$4,$5));}
    | PARSEOP_LLESSEQUAL '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LLessTerm
    : PARSEOP_LLESS '('             {$<n>$ = TrCreateLeafNode (PARSEOP_LLESS);}
        TermArg
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_LLESS '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LNotEqualTerm
    : PARSEOP_LNOTEQUAL '('         {$<n>$ = TrCreateLeafNode (PARSEOP_LEQUAL);}
        TermArg
        TermArgItem
        ')'                         {$$ = TrCreateNode (PARSEOP_LNOT, 1,
                                        TrLinkChildren ($<n>3,2,$4,$5));}
    | PARSEOP_LNOTEQUAL '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LNotTerm
    : PARSEOP_LNOT '('              {$<n>$ = TrCreateLeafNode (PARSEOP_LNOT);}
        TermArg
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_LNOT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LoadTableTerm
    : PARSEOP_LOADTABLE '('         {$<n>$ = TrCreateLeafNode (PARSEOP_LOADTABLE);}
        TermArg
        TermArgItem
        TermArgItem
        OptionalListString
        OptionalListString
        OptionalReference
        ')'                         {$$ = TrLinkChildren ($<n>3,6,$4,$5,$6,$7,$8,$9);}
    | PARSEOP_LOADTABLE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LoadTerm
    : PARSEOP_LOAD '('              {$<n>$ = TrCreateLeafNode (PARSEOP_LOAD);}
        NameString
        RequiredTarget
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_LOAD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

LocalTerm
    : PARSEOP_LOCAL0                {$$ = TrCreateLeafNode (PARSEOP_LOCAL0);}
    | PARSEOP_LOCAL1                {$$ = TrCreateLeafNode (PARSEOP_LOCAL1);}
    | PARSEOP_LOCAL2                {$$ = TrCreateLeafNode (PARSEOP_LOCAL2);}
    | PARSEOP_LOCAL3                {$$ = TrCreateLeafNode (PARSEOP_LOCAL3);}
    | PARSEOP_LOCAL4                {$$ = TrCreateLeafNode (PARSEOP_LOCAL4);}
    | PARSEOP_LOCAL5                {$$ = TrCreateLeafNode (PARSEOP_LOCAL5);}
    | PARSEOP_LOCAL6                {$$ = TrCreateLeafNode (PARSEOP_LOCAL6);}
    | PARSEOP_LOCAL7                {$$ = TrCreateLeafNode (PARSEOP_LOCAL7);}
    ;

LOrTerm
    : PARSEOP_LOR '('               {$<n>$ = TrCreateLeafNode (PARSEOP_LOR);}
        TermArg
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_LOR '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

MatchTerm
    : PARSEOP_MATCH '('             {$<n>$ = TrCreateLeafNode (PARSEOP_MATCH);}
        TermArg
        ',' MatchOpKeyword
        TermArgItem
        ',' MatchOpKeyword
        TermArgItem
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,6,$4,$6,$7,$9,$10,$11);}
    | PARSEOP_MATCH '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

MethodTerm
    : PARSEOP_METHOD  '('           {$<n>$ = TrCreateLeafNode (PARSEOP_METHOD);}
        NameString
        OptionalByteConstExpr       {UtCheckIntegerRange ($5, 0, 7);}
        OptionalSerializeRuleKeyword
        OptionalByteConstExpr
        OptionalParameterTypePackage
        OptionalParameterTypesPackage
        ')' '{'
            TermList '}'            {$$ = TrLinkChildren ($<n>3,7,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),
                                        $5,$7,$8,$9,$10,$13);}
    | PARSEOP_METHOD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

MidTerm
    : PARSEOP_MID '('               {$<n>$ = TrCreateLeafNode (PARSEOP_MID);}
        TermArg
        TermArgItem
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,4,$4,$5,$6,$7);}
    | PARSEOP_MID '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ModTerm
    : PARSEOP_MOD '('               {$<n>$ = TrCreateLeafNode (PARSEOP_MOD);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_MOD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

MultiplyTerm
    : PARSEOP_MULTIPLY '('          {$<n>$ = TrCreateLeafNode (PARSEOP_MULTIPLY);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_MULTIPLY '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

MutexTerm
    : PARSEOP_MUTEX '('             {$<n>$ = TrCreateLeafNode (PARSEOP_MUTEX);}
        NameString
        ',' ByteConstExpr
        ')'                         {$$ = TrLinkChildren ($<n>3,2,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),$6);}
    | PARSEOP_MUTEX '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

NameTerm
    : PARSEOP_NAME '('              {$<n>$ = TrCreateLeafNode (PARSEOP_NAME);}
        NameString
        ',' DataObject
        ')'                         {$$ = TrLinkChildren ($<n>3,2,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),$6);}
    | PARSEOP_NAME '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

NAndTerm
    : PARSEOP_NAND '('              {$<n>$ = TrCreateLeafNode (PARSEOP_NAND);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_NAND '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

NoOpTerm
    : PARSEOP_NOOP                  {$$ = TrCreateNode (PARSEOP_NOOP, 0);}
    ;

NOrTerm
    : PARSEOP_NOR '('               {$<n>$ = TrCreateLeafNode (PARSEOP_NOR);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_NOR '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

NotifyTerm
    : PARSEOP_NOTIFY '('            {$<n>$ = TrCreateLeafNode (PARSEOP_NOTIFY);}
        SuperName
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_NOTIFY '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

NotTerm
    : PARSEOP_NOT '('               {$<n>$ = TrCreateLeafNode (PARSEOP_NOT);}
        TermArg
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_NOT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ObjectTypeTerm
    : PARSEOP_OBJECTTYPE '('        {$<n>$ = TrCreateLeafNode (PARSEOP_OBJECTTYPE);}
        ObjectTypeName
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_OBJECTTYPE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

OffsetTerm
    : PARSEOP_OFFSET '('
        AmlPackageLengthTerm
        ')'                         {$$ = TrCreateNode (PARSEOP_OFFSET,1,$3);}
    | PARSEOP_OFFSET '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

OpRegionTerm
    : PARSEOP_OPERATIONREGION '('   {$<n>$ = TrCreateLeafNode (PARSEOP_OPERATIONREGION);}
        NameString
        ',' OpRegionSpaceIdTerm
        TermArgItem
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,4,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),
                                        $6,$7,$8);}
    | PARSEOP_OPERATIONREGION '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

OpRegionSpaceIdTerm
    : RegionSpaceKeyword            {}
    | ByteConst                     {$$ = UtCheckIntegerRange ($1, 0x80, 0xFF);}
    ;

OrTerm
    : PARSEOP_OR '('                {$<n>$ = TrCreateLeafNode (PARSEOP_OR);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_OR '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

PackageTerm
    : PARSEOP_PACKAGE               {$<n>$ = TrCreateLeafNode (PARSEOP_VAR_PACKAGE);}
        OptionalDataCount
        '{' PackageList '}'         {$$ = TrLinkChildren ($<n>2,2,$3,$5);}

PowerResTerm
    : PARSEOP_POWERRESOURCE '('     {$<n>$ = TrCreateLeafNode (PARSEOP_POWERRESOURCE);}
        NameString
        ',' ByteConstExpr
        ',' WordConstExpr
        ')' '{'
            TermList '}'            {$$ = TrLinkChildren ($<n>3,4,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),
                                        $6,$8,$11);}
    | PARSEOP_POWERRESOURCE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

PrintfTerm
    : PARSEOP_PRINTF '('            {$<n>$ = TrCreateLeafNode (PARSEOP_PRINTF);}
        StringData
        PrintfArgList
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_PRINTF '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

PrintfArgList
    :                               {$$ = NULL;}
    | TermArg                       {$$ = $1;}
    | PrintfArgList ','
       TermArg                      {$$ = TrLinkPeerNode ($1, $3);}
    ;

ProcessorTerm
    : PARSEOP_PROCESSOR '('         {$<n>$ = TrCreateLeafNode (PARSEOP_PROCESSOR);}
        NameString
        ',' ByteConstExpr
        OptionalDWordConstExpr
        OptionalByteConstExpr
        ')' '{'
            TermList '}'            {$$ = TrLinkChildren ($<n>3,5,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),
                                        $6,$7,$8,$11);}
    | PARSEOP_PROCESSOR '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

RawDataBufferTerm
    : PARSEOP_DATABUFFER  '('       {$<n>$ = TrCreateLeafNode (PARSEOP_DATABUFFER);}
        OptionalWordConst
        ')' '{'
            ByteList '}'            {$$ = TrLinkChildren ($<n>3,2,$4,$7);}
    | PARSEOP_DATABUFFER '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

/*
 * In RefOf, the node isn't really a target, but we can't keep track of it after
 * we've taken a pointer to it. (hard to tell if a local becomes initialized this way.)
 */
RefOfTerm
    : PARSEOP_REFOF '('             {$<n>$ = TrCreateLeafNode (PARSEOP_REFOF);}
        SuperName
        ')'                         {$$ = TrLinkChildren ($<n>3,1,
                                        TrSetNodeFlags ($4, NODE_IS_TARGET));}
    | PARSEOP_REFOF '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ReleaseTerm
    : PARSEOP_RELEASE '('           {$<n>$ = TrCreateLeafNode (PARSEOP_RELEASE);}
        SuperName
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_RELEASE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ResetTerm
    : PARSEOP_RESET '('             {$<n>$ = TrCreateLeafNode (PARSEOP_RESET);}
        SuperName
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_RESET '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ReturnTerm
    : PARSEOP_RETURN '('            {$<n>$ = TrCreateLeafNode (PARSEOP_RETURN);}
        OptionalReturnArg
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_RETURN                {$$ = TrLinkChildren (
                                        TrCreateLeafNode (PARSEOP_RETURN),1,
                                        TrSetNodeFlags (TrCreateLeafNode (PARSEOP_ZERO),
                                            NODE_IS_NULL_RETURN));}
    | PARSEOP_RETURN '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ScopeTerm
    : PARSEOP_SCOPE '('             {$<n>$ = TrCreateLeafNode (PARSEOP_SCOPE);}
        NameString
        ')' '{'
            TermList '}'            {$$ = TrLinkChildren ($<n>3,2,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),$7);}
    | PARSEOP_SCOPE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ShiftLeftTerm
    : PARSEOP_SHIFTLEFT '('         {$<n>$ = TrCreateLeafNode (PARSEOP_SHIFTLEFT);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_SHIFTLEFT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ShiftRightTerm
    : PARSEOP_SHIFTRIGHT '('        {$<n>$ = TrCreateLeafNode (PARSEOP_SHIFTRIGHT);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_SHIFTRIGHT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

SignalTerm
    : PARSEOP_SIGNAL '('            {$<n>$ = TrCreateLeafNode (PARSEOP_SIGNAL);}
        SuperName
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_SIGNAL '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

SizeOfTerm
    : PARSEOP_SIZEOF '('            {$<n>$ = TrCreateLeafNode (PARSEOP_SIZEOF);}
        SuperName
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_SIZEOF '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

SleepTerm
    : PARSEOP_SLEEP '('             {$<n>$ = TrCreateLeafNode (PARSEOP_SLEEP);}
        TermArg
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_SLEEP '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

StallTerm
    : PARSEOP_STALL '('             {$<n>$ = TrCreateLeafNode (PARSEOP_STALL);}
        TermArg
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_STALL '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

StoreTerm
    : PARSEOP_STORE '('             {$<n>$ = TrCreateLeafNode (PARSEOP_STORE);}
        TermArg
        ',' SuperName
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,
                                        TrSetNodeFlags ($6, NODE_IS_TARGET));}
    | PARSEOP_STORE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

SubtractTerm
    : PARSEOP_SUBTRACT '('          {$<n>$ = TrCreateLeafNode (PARSEOP_SUBTRACT);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_SUBTRACT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

SwitchTerm
    : PARSEOP_SWITCH '('            {$<n>$ = TrCreateLeafNode (PARSEOP_SWITCH);}
        TermArg
        ')' '{'
            CaseDefaultTermList '}'
                                    {$$ = TrLinkChildren ($<n>3,2,$4,$7);}
    | PARSEOP_SWITCH '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ThermalZoneTerm
    : PARSEOP_THERMALZONE '('       {$<n>$ = TrCreateLeafNode (PARSEOP_THERMALZONE);}
        NameString
        ')' '{'
            TermList '}'            {$$ = TrLinkChildren ($<n>3,2,
                                        TrSetNodeFlags ($4, NODE_IS_NAME_DECLARATION),$7);}
    | PARSEOP_THERMALZONE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

TimerTerm
    : PARSEOP_TIMER '('             {$<n>$ = TrCreateLeafNode (PARSEOP_TIMER);}
        ')'                         {$$ = TrLinkChildren ($<n>3,0);}
    | PARSEOP_TIMER                 {$$ = TrLinkChildren (
                                        TrCreateLeafNode (PARSEOP_TIMER),0);}
    | PARSEOP_TIMER '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ToBCDTerm
    : PARSEOP_TOBCD '('             {$<n>$ = TrCreateLeafNode (PARSEOP_TOBCD);}
        TermArg
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_TOBCD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ToBufferTerm
    : PARSEOP_TOBUFFER '('          {$<n>$ = TrCreateLeafNode (PARSEOP_TOBUFFER);}
        TermArg
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_TOBUFFER '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ToDecimalStringTerm
    : PARSEOP_TODECIMALSTRING '('   {$<n>$ = TrCreateLeafNode (PARSEOP_TODECIMALSTRING);}
        TermArg
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_TODECIMALSTRING '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ToHexStringTerm
    : PARSEOP_TOHEXSTRING '('       {$<n>$ = TrCreateLeafNode (PARSEOP_TOHEXSTRING);}
        TermArg
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_TOHEXSTRING '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ToIntegerTerm
    : PARSEOP_TOINTEGER '('         {$<n>$ = TrCreateLeafNode (PARSEOP_TOINTEGER);}
        TermArg
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_TOINTEGER '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ToPLDTerm
    : PARSEOP_TOPLD '('             {$<n>$ = TrCreateLeafNode (PARSEOP_TOPLD);}
        PldKeywordList
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_TOPLD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

PldKeywordList
    :                               {$$ = NULL;}
    | PldKeyword
        PARSEOP_EXP_EQUALS Integer  {$$ = TrLinkChildren ($1,1,$3);}
    | PldKeyword
        PARSEOP_EXP_EQUALS String   {$$ = TrLinkChildren ($1,1,$3);}
    | PldKeywordList ','            /* Allows a trailing comma at list end */
    | PldKeywordList ','
        PldKeyword
        PARSEOP_EXP_EQUALS Integer  {$$ = TrLinkPeerNode ($1,TrLinkChildren ($3,1,$5));}
    | PldKeywordList ','
        PldKeyword
        PARSEOP_EXP_EQUALS String   {$$ = TrLinkPeerNode ($1,TrLinkChildren ($3,1,$5));}
    ;


ToStringTerm
    : PARSEOP_TOSTRING '('          {$<n>$ = TrCreateLeafNode (PARSEOP_TOSTRING);}
        TermArg
        OptionalCount
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_TOSTRING '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

ToUUIDTerm
    : PARSEOP_TOUUID '('
        StringData ')'              {$$ = TrUpdateNode (PARSEOP_TOUUID, $3);}
    | PARSEOP_TOUUID '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

UnicodeTerm
    : PARSEOP_UNICODE '('           {$<n>$ = TrCreateLeafNode (PARSEOP_UNICODE);}
        StringData
        ')'                         {$$ = TrLinkChildren ($<n>3,2,0,$4);}
    | PARSEOP_UNICODE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

UnloadTerm
    : PARSEOP_UNLOAD '('            {$<n>$ = TrCreateLeafNode (PARSEOP_UNLOAD);}
        SuperName
        ')'                         {$$ = TrLinkChildren ($<n>3,1,$4);}
    | PARSEOP_UNLOAD '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

WaitTerm
    : PARSEOP_WAIT '('              {$<n>$ = TrCreateLeafNode (PARSEOP_WAIT);}
        SuperName
        TermArgItem
        ')'                         {$$ = TrLinkChildren ($<n>3,2,$4,$5);}
    | PARSEOP_WAIT '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

XOrTerm
    : PARSEOP_XOR '('               {$<n>$ = TrCreateLeafNode (PARSEOP_XOR);}
        TermArg
        TermArgItem
        Target
        ')'                         {$$ = TrLinkChildren ($<n>3,3,$4,$5,$6);}
    | PARSEOP_XOR '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;

WhileTerm
    : PARSEOP_WHILE '('             {$<n>$ = TrCreateLeafNode (PARSEOP_WHILE);}
        TermArg
        ')' '{' TermList '}'
                                    {$$ = TrLinkChildren ($<n>3,2,$4,$7);}
    | PARSEOP_WHILE '('
        error ')'                   {$$ = AslDoError(); yyclearin;}
    ;
