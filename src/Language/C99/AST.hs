module Language.C99.AST where

{- IDENTIFIERS -}
{- 6.4.2.1 -}
data Ident = IdentBase IdentNonDigit
           | IdentConsNonDigit Ident IdentNonDigit
           | IdentCons Ident Digit

data IdentNonDigit = IdentNonDigit NonDigit
                   | IdentNonDigitUniv UnivCharName
                   {- Other implementation-defined characters -}

data NonDigit = NDUnderscore
              | NDa           | NDA
              | NDb           | NDB
              | NDc           | NDC
              | NDd           | NDD
              | NDe           | NDE
              | NDf           | NDF
              | NDg           | NDG
              | NDh           | NDH
              | NDi           | NDI
              | NDj           | NDJ
              | NDk           | NDK
              | NDl           | NDL
              | NDm           | NDM
              | NDn           | NDN
              | NDo           | NDO
              | NDp           | NDP
              | NDq           | NDQ
              | NDr           | NDR
              | NDs           | NDS
              | NDt           | NDT
              | NDu           | NDU
              | NDv           | NDV
              | NDw           | NDW
              | NDx           | NDX
              | NDy           | NDY
              | NDz           | NDZ

data Digit = DZero
           | DOne
           | DTwo
           | DThree
           | DFour
           | DFive
           | DSix
           | DSeven
           | DEight
           | DNine


{- UNIVERSAL CHARACTER NAMES -}
{- 6.4.3 -}
data UnivCharName = UnivCharName1 HexQuad
                  | UnivCharName2 HexQuad HexQuad

data HexQuad = HexQuad HexDigit HexDigit HexDigit HexDigit


{- CONSTANTS -}
{- 6.4.4 -}
data Const = ConstInt   IntConst
           | ConstFloat FloatConst
           | ConstEnum  EnumConst
           | ConstChar  CharConst

{- 6.4.4.1 -}
data IntConst = IntDec DecConst (Maybe IntSuffix)
              | IntOc  OcConst  (Maybe IntSuffix)
              | IntHex HexConst (Maybe IntSuffix)

data DecConst = DecBase NonzeroDigit
              | DecCons DecConst Digit

data OcConst = OcO
             | OcCons OcConst OcDigit

data HexConst = HexBase HexPrefix HexDigit
              | HexCons HexConst  HexDigit

data HexPrefix = OX

data NonzeroDigit = NonzeroOne
                  | NonzeroTwo
                  | NonzeroThree
                  | NonzeroFour
                  | NonzeroFive
                  | NonzeroSix
                  | NonzeroSeven
                  | NonzeroEight
                  | NonzeroNine

data OcDigit = OcZero
             | OcOne
             | OcTwo
             | OcThree
             | OcFour
             | OcFive
             | OcSix
             | OcSeven

data HexDigit = HexZero
              | HexOne
              | HexTwo
              | HexThree
              | HexFour
              | HexFive
              | HexSix
              | HexSeven
              | HexEight
              | HexNine
              | Hexa         | HexA
              | Hexb         | HexB
              | Hexc         | HexC
              | Hexd         | HexD
              | Hexe         | HexE
              | Hexf         | HexF

data IntSuffix
  = IntSuffixUnsignedLong     UnsignedSuffix (Maybe LongSuffix)
  | IntSuffixUnsignedLongLong UnsignedSuffix LongLongSuffix
  | IntSuffixLong             LongSuffix     (Maybe UnsignedSuffix)
  | IntSuffixLongLong         LongLongSuffix (Maybe UnsignedSuffix)

data UnsignedSuffix = U
data LongSuffix     = L
data LongLongSuffix = LL

{- 6.4.4.2 -}
data FloatConst = FloatDec DecFloatConst
                | FloatHex HexFloatConst

data DecFloatConst
  = DecFloatFrac   FracConst (Maybe ExpPart) (Maybe FloatSuffix)
  | DecFloatDigits DigitSeq  ExpPart         (Maybe FloatSuffix)

data HexFloatConst
  = HexFloatFrac   HexPrefix HexFracConst BinExpPart (Maybe FloatSuffix)
  | HexFloatDigits HexPrefix HexDigitSeq  BinExpPart (Maybe FloatSuffix)

data FracConst = FracZero (Maybe DigitSeq) DigitSeq
               | Frac                      DigitSeq

data ExpPart = E (Maybe Sign) DigitSeq

data Sign = SignPlus
          | SignMinus

data DigitSeq = DigitBase          Digit
              | DigitCons DigitSeq Digit

data HexFracConst = HexFracZero (Maybe HexDigitSeq) HexDigitSeq
                  | HexFrac                         HexDigitSeq

data BinExpPart = P (Maybe Sign) DigitSeq

data HexDigitSeq = HexDigitBase             HexDigit
                 | HexDigitCons HexDigitSeq HexDigit

data FloatSuffix = FF
                 | FL

{- 6.4.4.3 -}
data EnumConst = Enum Ident

{- 6.4.4.4 -}
data CharConst = Char  CCharSeq
               | CharL CCharSeq

data CCharSeq = CCharBase          CChar
              | CCharCons CCharSeq CChar

data CChar = CChar    Char      -- We are a bit lenient here
           | CCharEsc EscSeq

data EscSeq = EscSimple SimpleEscSeq
            | EscOc     OcEscSeq
            | EscHex    HexEscSeq
            | EscUniv   UnivCharName

data SimpleEscSeq = SimpleEscQuote
                  | SimpleEscDQuote
                  | SimpleEscQuestion
                  | SimpleEscBackSlash
                  | SimpleEsca
                  | SimpleEscb
                  | SimpleEscf
                  | SimpleEscn
                  | SimpleEscr
                  | SimpleEsct
                  | SimpleEscv

data OcEscSeq = OcEsc1 OcDigit
              | OcEsc2 OcDigit OcDigit
              | OcEsc3 OcDigit OcDigit OcDigit

data HexEscSeq = HexEscBase           HexDigit
               | HexEscCons HexEscSeq HexDigit


{- STRING LITERALS -}
{- 6.4.5 -}
data StringLit = StringLit  (Maybe SCharSeq)
               | StringLitL (Maybe SCharSeq)

data SCharSeq = SCharBase          SChar
              | SCharCons SCharSeq SChar

data SChar = SChar    Char    -- We are a bit lenient here
           | SCharEsc EscSeq


{- EXPRESSIONS -}
{- 6.5.1 -}
data PrimExpr = PrimIdent  Ident
              | PrimConst  Const
              | PrimString StringLit
              | PrimExpr   Expr

{- 6.5.2 -}
data PostfixExpr = PostfixPrim      PrimExpr
                 | PostfixIndex     PostfixExpr Expr
                 | PostfixFunction  PostfixExpr (Maybe ArgExprList)
                 | PostfixDot       PostfixExpr Ident
                 | PostfixArrow     PostfixExpr Ident
                 | PostfixInc       PostfixExpr
                 | PostfixDec       PostfixExpr
                 | PostfixInits     TypeName    InitList

data ArgExprList = ArgExprListBase AssignExpr
                 | ArgExprListCons ArgExprList AssignExpr

{- 6.5.3 -}
data UnaryExpr = UnaryPostfix   PostfixExpr
               | UnaryInc       UnaryExpr
               | UnaryDec       UnaryExpr
               | UnaryOp        UnaryOp   CastExpr
               | UnarySizeExpr  UnaryExpr
               | UnarySizeType  TypeName

data UnaryOp = OpRef
             | OpDeref
             | OpPlus
             | OpMin
             | OpBNot
             | OpNot

{- 6.5.4 -}
data CastExpr = CastUnary UnaryExpr
              | Cast      TypeName CastExpr

{- 6.5.5 -}
data MultExpr = MultCast           CastExpr
              | MultMult MultExpr  CastExpr
              | MultDiv  MultExpr  CastExpr
              | MultMod  MultExpr  CastExpr

{- 6.5.6 -}
data AddExpr = AddMult         MultExpr
             | AddPlus AddExpr MultExpr
             | AddMin  AddExpr MultExpr

{- 6.5.7 -}
data ShiftExpr = ShiftAdd             AddExpr
               | ShiftLeft  ShiftExpr AddExpr
               | ShiftRight ShiftExpr AddExpr

{- 6.5.8 -}
data RelExpr = RelShift         ShiftExpr
             | RelLT    RelExpr ShiftExpr
             | RelGT    RelExpr ShiftExpr
             | RelLE    RelExpr ShiftExpr
             | RelGE    RelExpr ShiftExpr

{- 6.5.9 -}
data EqExpr = EqRel        RelExpr
            | EqEq  EqExpr RelExpr
            | EqNEq EqExpr RelExpr

{- 6.5.10 -}
data AndExpr = AndEq          EqExpr
             | And    AndExpr EqExpr

{- 6.5.11 -}
data XOrExpr = XOrAnd         AndExpr
             | XOr    XOrExpr AndExpr

{- 6.5.12 -}
data OrExpr = OrXOr        XOrExpr
            | Or    OrExpr XOrExpr

{- 6.5.13 -}
data LAndExpr = LAndOr          OrExpr
              | LAnd   LAndExpr OrExpr

{- 6.5.14 -}
data LOrExpr = LOrAnd         LAndExpr
             | LOr    LOrExpr LAndExpr

{- 6.5.15 -}
data CondExpr = CondLOr LOrExpr
              | Cond Expr CondExpr

{- 6.5.16 -}
data AssignExpr = AssignCond CondExpr
                | Assign UnaryExpr AssignOp AssignExpr

data AssignOp = AssignEq
              | AssignTimes
              | AssignDiv
              | AssignMod
              | AssignAdd
              | AssignSub
              | AssignShiftL
              | AssignShiftR
              | AssignAnd
              | AssignXOr
              | AssignOr

{- 6.5.17 -}
data Expr = ExprAssign      AssignExpr
          | Expr       Expr AssignExpr

{- 6.6 -}
data ConstExpr = Const CondExpr


{- DECLARATIONS -}
{- 6.7 -}
data Decln = Decln DeclnSpecs (Maybe InitDeclrList)

data DeclnSpecs = DeclnSpecsStorage StorageClassSpec (Maybe DeclnSpecs)
                | DeclnSpecsType    TypeSpec         (Maybe DeclnSpecs)
                | DeclnSpecsQual    TypeQual         (Maybe DeclnSpecs)
                | DeclnSpecsFun     FunSpec          (Maybe DeclnSpecs)

data InitDeclrList = InitDeclrBase               InitDeclr
                   | InitDeclrCons InitDeclrList InitDeclr

data InitDeclr = InitDeclr            Declr
               | InitDeclrInitr Declr Init

{- 6.7.1 -}
data StorageClassSpec = StorageTypedef
                      | StorageExtern
                      | StorageStatic
                      | StorageAuto
                      | StorageRegister

{- 6.7.2 -}
data TypeSpec = TypeVoid
              | TypeChar
              | TypeShort
              | TypeInt
              | TypeLong
              | TypeFloat
              | TypeDouble
              | TypeSigned
              | TypeUnsigned
              | TypeBool
              | TypeComplex
              | TypeStructUnion StructOrUnionSpec
              | TypeEnum        EnumSpec
              | TypeTypedef     TypedefName

{- 6.7.2.1 -}
data StructOrUnionSpec
  = StructOrUnionDecln     StructOrUnion (Maybe Ident) StructDeclnList
  | StructOrUnionForwDecln StructOrUnion Ident

data StructOrUnion = Struct
                   | Union

data StructDeclnList = StructDeclnBase                 StructDecln
                     | StructDeclnCons StructDeclnList StructDecln

data StructDecln = StructDecln SpecQualList StructDeclrList

data SpecQualList = SpecQualType TypeSpec (Maybe SpecQualList)
                  | SpecQualQual TypeQual (Maybe SpecQualList)

data StructDeclrList = StructDeclrBase                 StructDeclr
                     | StructDeclrCons StructDeclrList StructDeclr

data StructDeclr = StructDeclr    Declr
                 | StructDeclrBit (Maybe Declr) ConstExpr

{- 6.7.2.2 -}
data EnumSpec = EnumSpec (Maybe Ident) EnumrList
              | EnumSpecForw Ident

data EnumrList = EnumrBase           Enumr
               | EnumrCons EnumrList Enumr

data Enumr = Enumr     EnumConst
           | EnumrInit EnumConst ConstExpr

{- 6.7.3 -}
data TypeQual = QualConst
              | QualRestrict
              | QualVolatile

{- 6.7.4 -}
data FunSpec = SpecInline

{- 6.7.5 -}
data Declr = Declr (Maybe Ptr) DirectDeclr

data DirectDeclr
  = DirectDeclrIdent  Ident
  | DirectDeclrDeclr  Declr
  | DirectDeclrArray1 DirectDeclr (Maybe TypeQualList) (Maybe AssignExpr)
  | DirectDeclrArray2 DirectDeclr (Maybe TypeQualList) AssignExpr
  | DirectDeclrArray3 DirectDeclr TypeQualList AssignExpr
  | DirectDeclrArray4 DirectDeclr (Maybe TypeQualList)
  | DirectDeclrFun1   DirectDeclr ParamTypeList
  | DirectDeclrFun2   DirectDeclr (Maybe IdentList)

data Ptr = PtrBase (Maybe TypeQualList)
         | PtrCons (Maybe TypeQualList) Ptr

data TypeQualList = TypeQualBase              TypeQual
                  | TypeQualCons TypeQualList TypeQual

data ParamTypeList = ParamTypeList    ParamList
                   | ParamTypeListVar ParamList

data ParamList = ParamBase           ParamDecln
               | ParamCons ParamList ParamDecln

data ParamDecln = ParamDecln         DeclnSpecs Declr
                | ParamDeclnAbstract DeclnSpecs (Maybe DirectAbstractDeclr)

data IdentList = IdentListBase           Ident
               | IdentListCons IdentList Ident

{- 6.7.6 -}
data TypeName = TypeName SpecQualList (Maybe DirectAbstractDeclr)

data DirectAbstractDeclr
  = AbstractDeclr       DirectAbstractDeclr
  | AbstractDeclrArray1
      (Maybe DirectAbstractDeclr) (Maybe TypeQualList) (Maybe AssignExpr)
  | AbstractDeclrArray2
      (Maybe DirectAbstractDeclr) (Maybe TypeQualList) AssignExpr
  | AbstractDeclrArray3 (Maybe DirectAbstractDeclr) TypeQualList AssignExpr
  | AbstractDeclrArray4 (Maybe DirectAbstractDeclr)
  | AbstractDeclrFun    (Maybe DirectAbstractDeclr) (Maybe ParamTypeList)

{- 6.7.7 -}
data TypedefName = TypedefName Ident

{- 6.7.8 -}
data Init = InitExpr  AssignExpr
          | InitArray InitList
          -- We omit the specific case of InitArray ending with ,

data InitList = InitBase          (Maybe Design) Init
              | InitCons InitList (Maybe Design) Init

data Design = Design DesigrList

data DesigrList = DesigrBase            Desigr
                | DesigrCons DesigrList Desigr

data Desigr = DesigrConst ConstExpr
            | DesigrIdent Ident


{- STATEMENTS -}
{- 6.8 -}
data Stmt = StmtLabeled LabeledStmt
          | StmtCompund CompoundStmt
          | StmtExpr    ExprStmt
          | StmtSelect  SelectStmt
          | StmtIter    IterStmt
          | StmtJump    JumpStmt

{- 6.8.1 -}
data LabeledStmt = LabeledIdent   Ident     Stmt
                 | LabeledCase    ConstExpr Stmt
                 | LabeledDefault Stmt

{- 6.8.2 -}
data CompoundStmt = Compound (Maybe BlockItemList)

data BlockItemList = BlockItemBase               BlockItem
                   | BlockItemCons BlockItemList BlockItem

data BlockItem = BlockItemDecln Decln
               | BlockItemStmt  Stmt

{- 6.8.3 -}
data ExprStmt = ExprStmt (Maybe Expr)

{- 6.8.4 -}
data SelectStmt = SelectIf     Expr Stmt
                | SelectIfElse Expr Stmt Stmt
                | SelectSwitch Expr Stmt

{- 6.8.5 -}
data IterStmt = IterWhile Expr Stmt
              | IterDo Stmt Expr
              | IterForUpdate (Maybe Expr) (Maybe Expr) (Maybe Expr) Stmt
              | IterFor       Decln        (Maybe Expr) (Maybe Expr) Stmt

{- 6.8.6 -}
data JumpStmt = JumpGoto     Ident
              | JumpContinue
              | JumpBreak
              | JumpReturn   (Maybe Expr)
