\LoadClass[twoside,12pt]{ltjsreport}
\ProvidesClass{externalDesign}[2023.11.13 K.MIZOGUCHI]
\usepackage{silence}
\WarningFilter{caption}{Unknown document}
\usepackage[top=20truemm,bottom=20truemm,left=15truemm,right=15truemm,headheight=20pt]{geometry}
\usepackage{hyperref}
\usepackage{fancyhdr}
\usepackage{amsmath}
\usepackage{lastpage}
\usepackage{xcolor}
\usepackage{graphicx}
\usepackage{tabularx}
\hypersetup{
    colorlinks=true,
    citecolor=black,
    linkcolor=black,
    urlcolor=black
}
\newcolumntype{C}{>{\centering\arraybackslash}X}
\newcolumntype{R}{>{\raggedright\arraybackslash}X}
\newcolumntype{L}{>{\raggedleft\arraybackslash}X}
\renewcommand{\chaptermark}[1]{\markboth{\prechaptername\ \thechapter\ \postchaptername\ \ #1}{}}
\fancypagestyle{body}{
    \fancyhf{}
    \fancyhead[RO]{\leftmark\hspace{.5cm}\raisebox{-1mm}{\color{gray}\rule{.5mm}{6mm}}\hspace{.5cm}\thepage\hspace{.5cm}}
    \fancyhead[LE]{\hspace{.5cm}\thepage\hspace{.5cm}\raisebox{-1mm}{\color{gray}\rule{.5mm}{6mm}}\hspace{.5cm}\leftmark}
    \fancyfoot[C]{外部設計書}
    \renewcommand{\thepage}{\arabic{page}}
}

\fancypagestyle{mytoc}{
    \fancyhf{}
    \fancyhead[RO]{目次}
    \fancyhead[LE]{目次}
}

\renewcommand{\figurename}{図}
\renewcommand{\tablename}{表}
\renewcommand{\thefootnote}{\fnsymbol{footnote}}
\renewcommand{\contentsname}{目次}
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}
\renewcommand{\thetable}{\thechapter-\arabic{table}}
\renewcommand{\theequation}{\thechapter.\arabic{equation}}
\renewcommand{\eqref}[1]{式(\ref{#1})}
\newcommand{\figref}[1]{図\ref{#1}}
\newcommand{\tblref}[1]{表\ref{#1}}
\newcommand{\srcref}[1]{src.\ref{#1}}
\newcommand{\charef}[1]{\prechaptername\ref{#1}\postchaptername}
\newcommand{\secref}[1]{\ref{#1}節}

\renewcommand{\prechaptername}{第}
\renewcommand{\postchaptername}{項}
\renewcommand{\thechapter}{\arabic{chapter}}
\newcommand{\secs}[1]{\section*{#1}
    \addcontentsline{toc}{section}{#1}}

\makeatletter
\@addtoreset{figure}{chapter}
\@addtoreset{table}{chapter}
\@addtoreset{footnote}{page}
\renewcommand{\chapter}{%
    \if@openright\cleardoublepage\else\clearpage\fi
    \global\@topnum\z@
    \secdef\@chapter\@schapter}
\makeatother

\makeatletter
\def\version#1{\def\@version{#1}}
\def\systemName#1{\def\@systemName{#1}}
\def\date#1{\def\@date{#1}}
\def\groupName#1{\def\@groupName{#1}}
\renewcommand{\maketitle}{
    \thispagestyle{empty}
    \begin{center}
        \vspace{1cm}
        {\huge 外部設計書}
        \vfill
        {\Huge \@systemName }\\
        \vspace{2cm}
        {\LARGE \@groupName}\\
        \vspace{1cm}
        {\Large \@date}
        \vfill
        {\large 第\@version 版}
        \vspace{1cm}
    \end{center}
    \renewcommand{\footnoterule}{%
        \kern -3pt
        \hrule width 0pt height 0pt
        \kern 2pt
    }
}
\makeatother

\AtBeginDocument{
    \begin{titlepage}
        \thispagestyle{empty}
        \maketitle
    \end{titlepage}
    \thispagestyle{mytoc}
    \tableofcontents
    \setcounter{page}{0}
    \pagestyle{body}
}