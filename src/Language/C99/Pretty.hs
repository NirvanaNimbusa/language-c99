module Language.C99.Pretty where

import Language.C99.AST

import Text.PrettyPrint


-- Binary operator
bin :: (Pretty a, Pretty b) => a -> String -> b -> Doc
bin x op y = pretty x <+> text op <+> pretty y

class Pretty a where
  pretty :: a -> Doc

instance Pretty a => Pretty (Maybe a) where
  pretty (Just x) = pretty x
  pretty Nothing  = empty

{- IDENTIFIERS -}
{- 6.4.2.1 -}
instance Pretty Ident where
  pretty (IdentBase           idn) = pretty idn
  pretty (IdentConsNonDigit i idn) = pretty i <> pretty idn
  pretty (IdentCons         i d  ) = pretty i <> pretty d

instance Pretty IdentNonDigit where
  pretty (IdentNonDigit     nd ) = pretty nd
  pretty (IdentNonDigitUniv ucn) = pretty ucn

instance Pretty NonDigit where
  pretty c = case c of
    NDUnderscore -> char '_'
    NDa -> char 'a' ;      NDA -> char 'A'
    NDb -> char 'b' ;      NDB -> char 'B'
    NDc -> char 'c' ;      NDC -> char 'C'
    NDd -> char 'd' ;      NDD -> char 'D'
    NDe -> char 'e' ;      NDE -> char 'E'
    NDf -> char 'f' ;      NDF -> char 'F'
    NDg -> char 'g' ;      NDG -> char 'G'
    NDh -> char 'h' ;      NDH -> char 'H'
    NDi -> char 'i' ;      NDI -> char 'J'
    NDj -> char 'j' ;      NDJ -> char 'I'
    NDk -> char 'k' ;      NDK -> char 'K'
    NDl -> char 'l' ;      NDL -> char 'L'
    NDm -> char 'm' ;      NDM -> char 'M'
    NDn -> char 'n' ;      NDN -> char 'N'
    NDo -> char 'o' ;      NDO -> char 'O'
    NDp -> char 'p' ;      NDP -> char 'P'
    NDq -> char 'q' ;      NDQ -> char 'Q'
    NDr -> char 'r' ;      NDR -> char 'R'
    NDs -> char 's' ;      NDS -> char 'S'
    NDt -> char 't' ;      NDT -> char 'T'
    NDu -> char 'u' ;      NDU -> char 'U'
    NDv -> char 'v' ;      NDV -> char 'V'
    NDw -> char 'w' ;      NDW -> char 'W'
    NDx -> char 'x' ;      NDX -> char 'X'
    NDy -> char 'y' ;      NDY -> char 'Y'
    NDz -> char 'z' ;      NDZ -> char 'Z'

instance Pretty Digit where
  pretty c = case c of
    DZero  -> int 0
    DOne   -> int 1
    DTwo   -> int 2
    DThree -> int 3
    DFour  -> int 4
    DFive  -> int 5
    DSix   -> int 6
    DSeven -> int 7
    DEight -> int 8
    DNine  -> int 9


{- UNIVERSAL CHARACTER NAMES -}
{- 6.4.3 -}
instance Pretty UnivCharName where
  pretty (UnivCharName1 hq     ) = text "\\u" <> pretty hq
  pretty (UnivCharName2 hq1 hq2) = text "\\U" <> pretty hq1 <> pretty hq2

instance Pretty HexQuad where
  pretty (HexQuad hd1 hd2 hd3 hd4) =  pretty hd1 <> pretty hd2
                                   <> pretty hd3 <> pretty hd4


{- CONSTANTS -}
{- 6.4.4 -}
instance Pretty Const where
  pretty (ConstInt   ic) = pretty ic
  pretty (ConstFloat fc) = pretty fc
  pretty (ConstEnum  ec) = pretty ec
  pretty (ConstChar  cc) = pretty cc

{- 6.4.4.1 -}
instance Pretty IntConst where
  pretty (IntDec dc mis) = pretty dc <> pretty mis
  pretty (IntOc  oc mis) = pretty oc <> pretty mis
  pretty (IntHex hc mis) = pretty hc <> pretty mis

instance Pretty DecConst where
  pretty (DecBase    nzd) = pretty nzd
  pretty (DecCons dc d  ) = pretty dc <> pretty d

instance Pretty OcConst where

instance Pretty HexConst where

instance Pretty HexPrefix where

instance Pretty NonZeroDigit where
  pretty d = case d of
    NZOne   -> int 1
    NZTwo   -> int 2
    NZThree -> int 3
    NZFour  -> int 4
    NZFive  -> int 5
    NZSix   -> int 6
    NZSeven -> int 7
    NZEight -> int 8
    NZNine  -> int 9

instance Pretty OcDigit where

instance Pretty HexDigit where

instance Pretty IntSuffix where

instance Pretty UnsignedSuffix where
instance Pretty LongSuffix     where
instance Pretty LongLongSuffix where

{- 6.4.4.2 -}
instance Pretty FloatConst where

instance Pretty DecFloatConst where

instance Pretty HexFloatConst where

instance Pretty FracConst where

instance Pretty ExpPart where

instance Pretty Sign where

instance Pretty DigitSeq where

instance Pretty HexFracConst where

instance Pretty BinExpPart where

instance Pretty HexDigitSeq where

instance Pretty FloatSuffix where

{- 6.4.4.3 -}
instance Pretty EnumConst where

{- 6.4.4.4 -}
instance Pretty CharConst where

instance Pretty CCharSeq where

instance Pretty CChar where

instance Pretty EscSeq where

instance Pretty SimpleEscSeq where

instance Pretty OcEscSeq where

instance Pretty HexEscSeq where


{- STRING LITERALS -}
{- 6.4.5 -}
instance Pretty StringLit where
  pretty (StringLit  mcs) =             doubleQuotes (pretty mcs)
  pretty (StringLitL mcs) = char 'L' <> doubleQuotes (pretty mcs)

instance Pretty SCharSeq where
  pretty (SCharBase sc    ) = pretty sc
  pretty (SCharCons scs sc) = pretty scs <> pretty sc

instance Pretty SChar where
  pretty (SChar    c ) = char c
  pretty (SCharEsc es) = pretty es


{- EXPRESSIONS -}
{- 6.5.1 -}
instance Pretty PrimExpr where
  pretty (PrimIdent  i ) = pretty i
  pretty (PrimConst  c ) = pretty c
  pretty (PrimString sl) = pretty sl
  pretty (PrimExpr   e ) = parens (pretty e)

{- 6.5.2 -}
instance Pretty PostfixExpr where
  pretty (PostfixPrim     pe     ) = pretty pe
  pretty (PostfixIndex    pe e   ) = pretty pe <> brackets (pretty e)
  pretty (PostfixFunction pe mael) = pretty pe <> parens (pretty mael)
  pretty (PostfixDot      pe i   ) = pretty pe <> char '.' <> pretty i
  pretty (PostfixArrow    pe i   ) = pretty pe <> text "->" <> pretty i
  pretty (PostfixInc      pe     ) = pretty pe <> text "++"
  pretty (PostfixDec      pe     ) = pretty pe <> text "--"
  pretty (PostfixInits    tn il  ) = parens (pretty tn) <> braces (pretty il)

instance Pretty ArgExprList where
  pretty (ArgExprListBase     ae) = pretty ae
  pretty (ArgExprListCons ael ae) = pretty ael <> comma <+> pretty ae

{- 6.5.3 -}
instance Pretty UnaryExpr where
  pretty (UnaryPostfix  pe   ) = pretty pe
  pretty (UnaryInc      ue   ) = text "++" <> pretty ue
  pretty (UnaryDec      ue   ) = text "--" <> pretty ue
  pretty (UnaryOp       op ce) = pretty op <> pretty ce
  pretty (UnarySizeExpr ue   ) = text "sizeof" <+> pretty ue
  pretty (UnarySizeType tn   ) = text "sizeof" <> parens (pretty tn)

instance Pretty UnaryOp where
  pretty op = case op of
    UORef   -> char '&'
    UODeref -> char '*'
    UOPlus  -> char '+'
    UOMin   -> char '-'
    UOBNot  -> char '~'
    UONot   -> char '!'

{- 6.5.4 -}
instance Pretty CastExpr where
  pretty (CastUnary ue) = pretty ue
  pretty (Cast tn ce)   = parens (pretty tn) <> pretty ce

{- 6.5.5 -}
instance Pretty MultExpr where
  pretty (MultCast    ce) = pretty ce
  pretty (MultMult me ce) = bin me "*" ce
  pretty (MultDiv  me ce) = bin me "/" ce
  pretty (MultMod  me ce) = bin me "%" ce

{- 6.5.6 -}
instance Pretty AddExpr where
  pretty (AddMult    me) = pretty me
  pretty (AddPlus ae me) = bin ae "+" me
  pretty (AddMin  ae me) = bin ae "-" me

{- 6.5.7 -}
instance Pretty ShiftExpr where
  pretty (ShiftAdd         add) = pretty add
  pretty (ShiftLeft  shift add) = bin shift "<<" add
  pretty (ShiftRight shift add) = bin shift ">>" add

{- 6.5.8 -}
instance Pretty RelExpr where
  pretty (RelShift     shift) = pretty shift
  pretty (RelLT    rel shift) = bin rel "<"  shift
  pretty (RelGT    rel shift) = bin rel ">"  shift
  pretty (RelLE    rel shift) = bin rel "<=" shift
  pretty (RelGE    rel shift) = bin rel ">=" shift

{- 6.5.9 -}
instance Pretty EqExpr where
  pretty (EqRel    rel) = pretty rel
  pretty (EqEq  eq rel) = bin eq "==" rel
  pretty (EqNEq eq rel) = bin eq "!=" rel

{- 6.5.10 -}
instance Pretty AndExpr where
  pretty (AndEq     eq) = pretty eq
  pretty (And   and eq) = bin and "&" eq

{- 6.5.11 -}
instance Pretty XOrExpr where
  pretty (XOrAnd     and) = pretty and
  pretty (XOr    xor and) = bin xor "^" and

{- 6.5.12 -}
instance Pretty OrExpr where
  pretty (OrXOr    xor) = pretty xor
  pretty (Or    or xor) = bin or "|" xor

{- 6.5.13 -}
instance Pretty LAndExpr where
  pretty (LAndOr     or) = pretty or
  pretty (LAnd   and or) = bin and "&&" or

{- 6.5.14 -}
instance Pretty LOrExpr where
  pretty (LOrAnd    and) = pretty and
  pretty (LOr    or and) = bin or "||" and

{- 6.5.15 -}
instance Pretty CondExpr where
  pretty (CondLOr le     ) = pretty le
  pretty (Cond    le e ce) = pretty le <+> char '?' <+> pretty e <+> colon <+> pretty ce

{- 6.5.16 -}
instance Pretty AssignExpr where
  pretty (AssignCond ce)   = pretty ce
  pretty (Assign ue op ae) = pretty ue <+> pretty op <+> pretty ae

instance Pretty AssignOp where
  pretty op = case op of
    AEq     -> text "="
    ATimes  -> text "*="
    ADiv    -> text "/="
    AMod    -> text "%="
    AAdd    -> text "+="
    ASub    -> text "-="
    AShiftL -> text "<<="
    AShiftR -> text ">>="
    AAnd    -> text "&="
    AXOr    -> text "^="
    AOr     -> text "|="

{- 6.5.17 -}
instance Pretty Expr where
  pretty (ExprAssign   ae) = pretty ae
  pretty (Expr       e ae) = pretty e <> comma <+> pretty ae

{- 6.6 -}
instance Pretty ConstExpr where
  pretty (Const ce) = pretty ce


{- DECLARATIONS -}
{- 6.7 -}
instance Pretty Decln where
  pretty (Decln ds midl) = pretty ds <+> pretty midl

instance Pretty DeclnSpecs where
  pretty (DeclnSpecsStorage scs mds) = pretty scs <+> pretty mds
  pretty (DeclnSpecsType    ts  mds) = pretty ts  <+> pretty mds
  pretty (DeclnSpecsQual    tq  mds) = pretty tq  <+> pretty mds
  pretty (DeclnSpecsFun     fs  mds) = pretty fs  <+> pretty mds

instance Pretty InitDeclrList where
  pretty (InitDeclrBase     id) = pretty id
  pretty (InitDeclrCons idl id) = pretty idl <> comma <+> pretty id

instance Pretty InitDeclr where
  pretty (InitDeclr      d  ) = pretty d
  pretty (InitDeclrInitr d i) = pretty d <+> equals <+> pretty i

{- 6.7.1 -}
instance Pretty StorageClassSpec where
  pretty c = case c of
    STypedef  -> text "typedef"
    SExtern   -> text "extern"
    SStatic   -> text "static"
    SAuto     -> text "auto"
    SRegister -> text "register"

{- 6.7.2 -}
instance Pretty TypeSpec where
  pretty ty = case ty of
    TVoid               -> text "void"
    TChar               -> text "char"
    TShort              -> text "short"
    TInt                -> text "int"
    TLong               -> text "long"
    TFloat              -> text "float"
    TDouble             -> text "double"
    TSigned             -> text "signed"
    TUnsigned           -> text "unsigned"
    TBool               -> text "_Bool"
    TComplex            -> text "_Complex"
    TStructOrUnion sous -> pretty sous
    TEnum          es   -> pretty es
    TTypedef       tn   -> pretty tn

{- 6.7.2.1 -}
instance Pretty StructOrUnionSpec where

instance Pretty StructOrUnion where

instance Pretty StructDeclnList where

instance Pretty StructDecln where

instance Pretty SpecQualList where

instance Pretty StructDeclrList where

instance Pretty StructDeclr where

{- 6.7.2.2 -}
instance Pretty EnumSpec where

instance Pretty EnumrList where

instance Pretty Enumr where

{- 6.7.3 -}
instance Pretty TypeQual where
  pretty q = case q of
    QConst    -> text "const"
    QRestrict -> text "restrict"
    QVolatile -> text "volatile"

{- 6.7.4 -}
instance Pretty FunSpec where
  pretty SpecInline = text "inline"

{- 6.7.5 -}
instance Pretty Declr where
  pretty (Declr mptr dd) = pretty mptr <+> pretty dd

instance Pretty DirectDeclr where
  pretty (DirectDeclrIdent i) = pretty i

instance Pretty Ptr where

instance Pretty TypeQualList where

instance Pretty ParamTypeList where

instance Pretty ParamList where

instance Pretty ParamDecln where

instance Pretty IdentList where

{- 6.7.6 -}
instance Pretty TypeName where

instance Pretty DirectAbstractDeclr where

{- 6.7.7 -}
instance Pretty TypedefName where
  pretty (TypedefName i) = pretty i

{- 6.7.8 -}
instance Pretty Init where
  pretty (InitExpr  ae) = pretty ae
  pretty (InitArray il) = braces (pretty il)

instance Pretty InitList where
  pretty (InitBase    md i) =                        pretty md <+> pretty i
  pretty (InitCons il md i) = pretty il <> comma <+> pretty md <+> pretty i

instance Pretty Design where
  pretty (Design dl) = pretty dl <+> char '='

instance Pretty DesigrList where
  pretty (DesigrBase    d) = pretty d
  pretty (DesigrCons dl d) = pretty dl <+> pretty d

instance Pretty Desigr where
  pretty (DesigrConst ce) = brackets (pretty ce)
  pretty (DesigrIdent i ) = char '.' <> pretty i

{- STATEMENTS -}
{- 6.8 -}
instance Pretty Stmt where
  pretty (StmtLabeled  ls) = pretty ls
  pretty (StmtCompound cs) = pretty cs
  pretty (StmtExpr     es) = pretty es
  pretty (StmtSelect   ss) = pretty ss
  pretty (StmtIter     is) = pretty is
  pretty (StmtJump     js) = pretty js

{- 6.8.1 -}
instance Pretty LabeledStmt where
  pretty (LabeledIdent i  s) =                 pretty i  <> colon <+> pretty s
  pretty (LabeledCase  ce s) = text "case" <+> pretty ce <> colon <+> pretty s
  pretty (LabeledDefault  s) = text "default"            <> colon <+> pretty s

{- 6.8.2 -}
instance Pretty CompoundStmt where
  pretty (Compound Nothing) = empty
  pretty (Compound mbil   ) = braces (pretty mbil)

instance Pretty BlockItemList where
  pretty (BlockItemBase     bi) = pretty bi
  pretty (BlockItemCons bil bi) = pretty bil <> pretty bi

instance Pretty BlockItem where
  pretty (BlockItemDecln d) = pretty d <> semi
  pretty (BlockItemStmt  s) = pretty s <> semi

{- 6.8.3 -}
instance Pretty ExprStmt where
  pretty (ExprStmt Nothing) = empty
  pretty (ExprStmt me)      = pretty me <> semi

{- 6.8.4 -}
instance Pretty SelectStmt where
  pretty (SelectIf c s) = text "if" <+> parens (pretty c) <+> pretty s
  pretty (SelectIfElse c s1 s2) =
    text "if" <+> parens (pretty c) <+> pretty s1 <+> text "else" <+> pretty s2
  pretty (SelectSwitch c s) = text "switch" <+> parens (pretty c) <+> pretty s

{- 6.8.5 -}
instance Pretty IterStmt where
  pretty (IterWhile c s) = text "while" <+> parens (pretty c) <+> pretty s
  pretty (IterDo    s c) =
    text "do" <+> pretty s <+> text "while" <+> parens (pretty c) <> semi
  pretty (IterForUpdate me1 me2 me3 s) =
    text "for" <+> parens ( pretty me1 <> semi <+>
                            pretty me2 <> semi <+>
                            pretty me3 ) <+> pretty s
  pretty (IterFor d me1 me2 s) =
    text "for" <+> parens ( pretty d <+> pretty me1 <> semi
                            <+> pretty me2 ) <+> pretty s

{- 6.8.6 -}
instance Pretty JumpStmt where
  pretty (JumpGoto i)    = text "goto" <+> pretty i <> semi
  pretty JumpContinue    = text "continue"          <> semi
  pretty JumpBreak       = text "break"             <> semi
  pretty (JumpReturn me) = text "return" <+> pretty me <> semi


{- EXTERNAL DEFINITIONS -}
{- 6.9 -}
instance Pretty TransUnit where
  pretty (TransUnitBase    ed) =               pretty ed
  pretty (TransUnitCons tu ed) = pretty tu <+> pretty ed

instance Pretty ExtDecln where
  pretty (ExtFun fd)  = pretty fd
  pretty (ExtDecln d) = pretty d

{- 6.9.1 -}
instance Pretty FunDef where
  pretty (FunDef ds d mdl cs) = pretty ds <+> pretty d <+> parens (pretty mdl) <+> pretty cs

instance Pretty DeclnList where
  pretty (DeclnBase    d) = pretty d
  pretty (DeclnCons dl d) = pretty dl <> comma <+> pretty d
