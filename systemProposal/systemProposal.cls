\LoadClass[twoside]{ltjsreport}
\ProvidesClass{systemProposal}[2023.06.23 K.MIZOGUCHI]
\usepackage{silence}
\WarningFilter{caption}{Unknown document}
\usepackage[top=20truemm,bottom=20truemm,left=15truemm,right=15truemm,headheight=20pt]{geometry}
\usepackage{hyperref}
\usepackage{fancyhdr}
\usepackage{amsmath}
\usepackage{lastpage}
\usepackage{xcolor}
\usepackage{graphicx}
\hypersetup{
    colorlinks=true,
    citecolor=black,
    linkcolor=black,
    urlcolor=black
}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\fancypagestyle{body}{
    \fancyhf{}
    \fancyhead[RE]{\leftmark\hspace{.5cm}\raisebox{-1mm}{\color{gray}\rule{.5mm}{6mm}}\hspace{.5cm}\thepage\hspace{.5cm}}
    \fancyhead[LO]{\hspace{.5cm}\thepage\hspace{.5cm}\raisebox{-1mm}{\color{gray}\rule{.5mm}{6mm}}\hspace{.5cm}\leftmark}
    \pagenumbering{arabic}
}

\fancypagestyle{mytoc}{
    \fancyhf{}
    \fancyhead[RE]{目次\hspace{.5cm}\raisebox{-1mm}{\color{gray}\rule{.5mm}{6mm}}\hspace{.5cm}\thepage\hspace{.5cm}}
    \fancyhead[LO]{\hspace{.5cm}\thepage\hspace{.5cm}\raisebox{-1mm}{\color{gray}\rule{.5mm}{6mm}}\hspace{.5cm}目次}
    \pagenumbering{roman}
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

\renewcommand{\prechaptername}{}
\renewcommand{\postchaptername}{}
\renewcommand{\thechapter}{}

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
        {\huge システム提案書}
        \vfill
        {\Huge \@systemName }\\
        \vspace{2cm}
        {\LARGE \@groupName}\\
        \vspace{1cm}
        {\Large \@date}
        \vfill
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
    \pagestyle{body}
    \setcounter{page}{1}
}