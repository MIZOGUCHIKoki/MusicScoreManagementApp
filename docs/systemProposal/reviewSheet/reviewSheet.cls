\LoadClass[landscape,12pt]{jlreq}
\ProvidesClass{reviewSheet}[2023.10.17 K.MIZOGUCHI]
\usepackage[top=20truemm,bottom=20truemm,right=5truemm,left=5truemm,headheight=22pt]{geometry}
\usepackage{xltabular,tabularx,fancyhdr,lastpage}

\newcolumntype{C}{>{\centering\arraybackslash}X}
\newcolumntype{R}{>{\raggedright\arraybackslash}X}
\newcolumntype{L}{>{\raggedleft\arraybackslash}X}

\fancyhf{}
\fancyhead[L]{}
\fancyhead[R]{通番：\thepage\ / \pageref{LastPage}}
\fancyfoot[C]{レビュ記録表}
\fancyfoot[L]{\fbox{\textbf{分類}\ R：訂正要求，Q：質問，C：コメント}}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}

\usepackage{pifont}
\newcommand{\ck}{{\normalsize\bfseries\ding{51}}}

\makeatletter
\def\dateTime#1{\def\@dateTime{#1}} % レビュ日
\def\room#1{\def\@room{#1}} % レビュ実施場所
\def\groupName#1{\def\@groupName{#1}} % チーム名
\def\author#1{\def\@author{#1}} % 記入者
\def\object#1{\def\@object{#1}} % レビュ対象物
\def\member#1{\def\@member{#1}} % 参加者
\AtBeginDocument{
    \begin{center}
        \LARGE\bfseries レビュ記録表
    \end{center}
    \vspace{1cm}
    \begin{tabularx}{\textwidth}{|lL|lr|lr|lr|}
        \hline
        \textbf{レビュ実施日時} & \@dateTime & \textbf{実施場所}      & \@room                        & \textbf{チーム名} & \@groupName & \textbf{記入者} & \@author \\
        \hline
        \textbf{レビュ対象物}  & \@object   & \textbf{参加者（学籍番号）} & \multicolumn{5}{r|}{\@member}                                                         \\
        \hline
    \end{tabularx}
}
\makeatother

\newenvironment{rev}{
    \scriptsize
    \renewcommand{\arraystretch}{1.5}
    \newcommand{\bk}{\\\hline}
    \xltabular{\textwidth}{|c|c|c|R|c|c|l|R|l|l|l|}
    \hline
    番号 & 分類 & 頁/行 & \multicolumn{1}{c|}{指摘事項} & \multicolumn{1}{c|}{緊急} & \multicolumn{1}{c|}{重要} & \multicolumn{1}{c|}{訂正担当} & \multicolumn{1}{c|}{訂正内容} & \multicolumn{1}{c|}{訂正日} & \multicolumn{1}{c|}{確認者} & \multicolumn{1}{c|}{確認日}\\
    \hline\hline
    \endhead
    \hline
    \endfoot
}{
    \endxltabular
}