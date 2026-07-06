\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{tesisutec}[2017/05/03 v1.0 LaTeX document class]
\def\baseclass{book}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\def\@checkoptions#1#2{
  \edef\@curroptions{\@ptionlist{\@currname.\@currext}}
  \@tempswafalse
  \@tfor\@this:=#2\do{
    \@expandtwoargs\in@{,\@this,}{,\@curroptions,}
    \ifin@ \@tempswatrue \@break@tfor \fi}
  \let\@this\@empty
  \if@tempswa \else \PassOptionsToClass{#1}{\baseclass}\fi
}
\@checkoptions{11pt}{{10pt}{11pt}{12pt}}
\PassOptionsToClass{a4paper}{\baseclass}
\ProcessOptions\relax
\LoadClass{\baseclass}

\newcommand\bhrule{\typeout{------------------------------------------------------------------------------}}

% Contador y comando para añadir entradas al TOC (debe estar antes de intro/conclusions/recommendations)
\newcounter{dummy}
\newcommand\addtotoc[1]{\refstepcounter{dummy}\addcontentsline{toc}{chapter}{#1}}

% For Spanish
\usepackage[utf8]{inputenc}
\PassOptionsToPackage{english}{babel}
\PassOptionsToPackage{spanish,es-tabla,es-nodecimaldot}{babel}
\RequirePackage{babel}
% For Times New Roman
\RequirePackage{times}
% For section styles
\RequirePackage{titlesec}

% For contents table
\RequirePackage{tocloft}
%\usepackage[tocflat]{tocstyle}
%\usetocstyle{standard}

% ====================================================================
\newcommand\declaracionautoria[1]{
  \setstretch{1.5}
  \thispagestyle{empty}
  \chapter*{DECLARACIÓN DE AUTORÍA}
  \addcontentsline{toc}{chapter}{DECLARACIÓN DE AUTORÍA}
  {\normalsize #1}
  \vspace{2cm}
  \noindent Fray Bentos, \dateMY\\
  \vspace{1.5cm}
  \hfill\rule[0.5em]{10em}{0.5pt}\\
  \hfill \authornames
  \ifx\authornameii\@empty\else
    \vspace{1cm}
    \hfill\rule[0.5em]{10em}{0.5pt}\\
    \hfill \authornameii
  \fi
  \clearpage
}

% ====================================================================
\newcommand\Aprobado[1]{
  \setstretch{1.5}  % Set line spacing to 1.5
  \thispagestyle{empty}
  \noindent La tesis\\
  \textbf{\@title} \\
  ha sido aprobada.
  {\normalsize #1}

  \vspace{2.5cm}
  \hfill\rule[0.5em]{16.5em}{0.5pt} \\  % Line for the signature
  ${~}$\hfill \presname \\

  \vspace{1.5cm}
  \hfill\rule[0.5em]{16.5em}{0.5pt} \\  % Line for the signature
  ${~}$\hfill \supname \\

  \vspace{1.5cm}
  \hfill\rule[0.5em]{16.5em}{0.5pt} \\  % Line for the signature
  ${~}$\hfill \examname \\

  \clearpage
}

% ====================================================================
\newcommand\dedicatory[1]{
  \setstretch{1.0}  % Set line spacing to 1.0
  \thispagestyle{empty}
  \null\vfil
  \vskip 60\p@
  \vspace{4.5cm}
  ${~}$\hfill \textit{Dedicatoria}: \\
  \begin{flushright}{ \sl #1}\end{flushright}
  \vfil\null
  \cleardoublepage
  \setstretch{1.5}  % Set line spacing to 1.0
}


% ====================================================================
\newcommand\acknowledgements[1]{
  \setstretch{1.0}  % Set line spacing to 1.0
  \thispagestyle{empty}
  \null\vfil
  \vskip 60\p@
  \vspace{4.5cm}
  ${~}$\hfill \textit{Agradecimientos}: \\
  \begin{flushright}{ \sl #1}\end{flushright}
  \vfil\null
  \cleardoublepage
  \setstretch{1.5}  % Set line spacing to 1.0
}


% ====================================================================
\newcommand\intro[1]{
  \btypeout{INTRODUCCIÓN}
  \addtotoc{INTRODUCCIÓN}
  \thispagestyle{plain}
  \begin{center}{\Large \textbf{INTRODUCCIÓN} \par}\end{center}
  \vspace{0.5cm}
  {\normalsize #1}
  \vfil\vfil\null
  \clearpage
}


% ====================================================================
\newcommand\conclusions[1]{
  \btypeout{CONCLUSIONES}
  \addtotoc{CONCLUSIONES}
  \clearpage
  \thispagestyle{plain}
  \begin{center}{\Large \textbf{CONCLUSIONES} \par}\end{center}
  \vspace{0.5cm}
  {\normalsize #1}
  \vfil\vfil\null
  \clearpage
}


% ====================================================================
\newcommand\recommendations[1]{
  \btypeout{RECOMENDACIONES}
  \addtotoc{RECOMENDACIONES}
  \clearpage
  \thispagestyle{plain}
  %\null\vfil
  % \vskip 60\p@
  \begin{center}{\Large \textbf{RECOMENDACIONES} \par}\end{center}
  % \vskip 60\p@
  \vspace{0.5cm}
  {\normalsize #1}
  \vfil\vfil\null
  \clearpage
  % \cleardoublepage
}


% ====================================================================

\newcommand\btypeout[1]{\bhrule\typeout{\space #1}\bhrule}
\usepackage{setspace}
\onehalfspacing
\setlength{\parindent}{1.25cm}
\setlength{\parskip}{2.0ex plus0.5ex minus0.2ex}
\usepackage{vmargin}
\setmarginsrb           { 3.0cm}  % left margin
                        { 3.0cm}  % top margin
                        { 3.0cm}  % right margin
                        { 3.0cm}  % bottom margin
                        {  20pt}  % head height
                        {0.25in}  % head sep
                        {   9pt}  % foot height
                        { 0.3in}  % foot sep
\raggedbottom
\setlength{\topskip}{1\topskip \@plus 5\p@}
\doublehyphendemerits=10000       % No consecutive line hyphens.
\brokenpenalty=10000              % No broken words across columns/pages.
\widowpenalty=9999                % Almost no widows at bottom of page.
\clubpenalty=9999                 % Almost no orphans at top of page.
\interfootnotelinepenalty=9999    % Almost never break footnotes.
\usepackage{fancyhdr}
\chead{}\rfoot{\thepage}\lfoot{}\cfoot{}
\renewcommand{\headrulewidth}{0pt} % To remove header line
\fancyhead{}
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\btypeout{\thechapter\space #1}\markboth{\@chapapp\ \thechapter\ #1}{\@chapapp\ \thechapter\ #1}}
\renewcommand{\sectionmark}[1]{}
\renewcommand{\subsectionmark}[1]{}
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\thispagestyle{empty}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\usepackage{amsmath,amsfonts,amssymb,amscd,amsthm,xspace}
\theoremstyle{plain}
\newtheorem{example}{Example}[chapter]
\newtheorem{theorem}{Theorem}[chapter]
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\usepackage[centerlast,small,sc]{caption}
\setlength{\captionmargin}{20pt}
\newcommand{\fref}[1]{Figure~\ref{#1}}
\newcommand{\tref}[1]{Table~\ref{#1}}
\newcommand{\eref}[1]{Equation~\ref{#1}}
\newcommand{\cref}[1]{Chapter~\ref{#1}}
\newcommand{\sref}[1]{Section~\ref{#1}}
\newcommand{\aref}[1]{Appendix~\ref{#1}}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\dbltopfraction}{.85}
\renewcommand{\floatpagefraction}{0.75}
\renewcommand{\dblfloatpagefraction}{.75}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}
\usepackage{graphicx}
\graphicspath{{images/}}
\usepackage{tikz}
\usetikzlibrary{positioning,calc}
\usepackage{epstopdf}
\usepackage[font=scriptsize]{subcaption}
\usepackage{booktabs}
\usepackage{rotating}
\usepackage{listings}

\usepackage[pdfpagemode={UseOutlines},bookmarks=true,bookmarksopen=true,
   bookmarksopenlevel=0,bookmarksnumbered=true,hypertexnames=false,
   colorlinks,linkcolor={black},citecolor={blue},urlcolor={red},
   pdfstartview={FitV},unicode,breaklinks=true]{hyperref}
\pdfstringdefDisableCommands{
   \let\\\space
}
\newcommand*{\supervisor}[1]{\def\supname{#1}}
\newcommand*{\cotutor}[1]{\def\cotutorname{#1}}
\newcommand*{\examiner}[1]{\def\examname{#1}}
\newcommand*{\president}[1]{\def\presname{#1}}
\newcommand*{\degree}[1]{\def\degreename{#1}}
\renewcommand*{\author}[1]{\def\authornames{#1}}
\newcommand*{\authorid}[1]{\def\studentid{#1}}
\newcommand*{\authorci}[1]{\def\authorcino{#1}}
\newcommand*{\authorii}[1]{\def\authornameii{#1}}
\newcommand*{\authorciii}[1]{\def\authorcinoii{#1}}
\newcommand*{\email}[1]{\def\authoremail{#1}}
\newcommand*{\department}[1]{\def\deptname{#1}}
\newcommand*{\itr}[1]{\def\itrname{#1}}
\newcommand*{\sede}[1]{\def\sedename{#1}}
\newcommand*{\carrera}[1]{\def\carrename{#1}}
\newcommand*{\codigoproyecto}[1]{\def\codigoproy{#1}}
\newcommand*{\subject}[1]{\def\subjectname{#1}}
\newcommand*{\keywords}[1]{\def\keywordnames{#1}}
\renewcommand*{\date}[1]{\def\dateMY{#1}}
\supervisor  {}
\cotutor     {}
\examiner    {}
\degree      {}
\author      {}
\authorci    {}
\authorii    {}
\authorciii   {}
\email       {}
\itr         {ITR Suroeste}
\sede        {Sede Fray Bentos}
\carrera     {Ingeniería en Mecatrónica}
\codigoproyecto{}
\subject     {}
\keywords    {}


% ====================================================================
\renewcommand\maketitle{
  \btypeout{Title Page}
  \hypersetup{pdftitle={\@title}}
  \hypersetup{pdfsubject=\subjectname}
  \hypersetup{pdfauthor=\authornames}
  \hypersetup{pdfkeywords=\keywordnames}
  \thispagestyle{empty}
  \begin{titlepage}
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \setcounter{footnote}{0}
    % Elemento decorativo azul (esquina superior izquierda, según referencia)
    \begin{tikzpicture}[remember picture, overlay]
      \fill[blue!60!cyan] (current page.north west) -- 
        ($(current page.north west)+(5.5cm,0)$) -- 
        ($(current page.north west)+(5.5cm,-2.8cm)$) .. controls 
        ($(current page.north west)+(2.5cm,-1.8cm)$) and 
        ($(current page.north west)+(0.5cm,-0.3cm)$) .. (current page.north west) -- cycle;
      \draw[gray!50, line width=0.4pt] ($(current page.north west)+(5.5cm,-2.8cm)$) .. controls (10cm,\paperheight-2.2cm) and (14cm,\paperheight-1.6cm) .. (current page.north east);
    \end{tikzpicture}
    \vspace{2.5cm}
    % Banda de logos institucionales
    \noindent
    \begin{minipage}[c]{0.95\textwidth}
      \centering
      \begin{tabular}{@{}c@{\hspace{0.8em}|}\hspace{0.4em}c@{\hspace{0.8em}|}\hspace{0.4em}c@{\hspace{0.8em}|}\hspace{0.4em}c@{}}
        \begin{minipage}{2.2cm}
          \centering
          \includegraphics[height=1.8cm]{logo_utec_nego_azul.png}\\[0.3em]
          {\small\textbf{Universidad Tecnológica}}
        \end{minipage}
        &
        \begin{minipage}{2.2cm}
          \centering
          \includegraphics[height=1.3cm]{06-isologotipo-para-fondo-blanco.png}
        \end{minipage}
        &
        \begin{minipage}{2.2cm}
          \centering
          \includegraphics[height=1.3cm]{Logo-UTU-Logo-Cian-Fondo-Blanco-1-scaled.png}
        \end{minipage}
        &
        \begin{minipage}{4.5cm}
          \centering
          {\small\textbf{\textcolor{blue!80!black}{DIRECCIÓN GENERAL DE}}\\[0.2em]
          {\small\textbf{\textcolor{blue!80!black}{EDUCACIÓN TÉCNICO PROFESIONAL}}}
        \end{minipage}
      \end{tabular}
    \end{minipage}
    \vspace{2.5cm}
    % Título
    \begin{center}
      {\LARGE\bfseries \@title \par}
      \vspace{1.5cm}
      {\large \textbf{Trabajo Final}\par}
      \vspace{0.3cm}
      {\large \carrename\ -- \itrname\ -- \sedename\par}
      \vspace{1.5cm}
      {\large Pregrado\par}
      \vfill
      {\large \bf \authornames \par}
      \ifx\authornameii\@empty
        \vspace{0.3cm}
        {\large C.I.\ \authorcino \par}
      \else
        \vspace{0.2cm}
        {\large \authornameii \par}
        \vspace{0.2cm}
        {\large C.I.\ \authorcino\ y \authorcinoii \par}
      \fi
      \vspace{0.3cm}
      {\large \authoremail \par}
      \vspace{1cm}
      {\large \bf Docente/s tutor/es\par}
      \vspace{0.3cm}
      {\large \supname \par}
      \ifx\cotutorname\@empty\else
        \vspace{0.2cm}
        {\large Co-tutor: \cotutorname \par}
      \fi
      \vfill
      {\large \textbf{Fecha de presentación}\par}
      \vspace{0.3cm}
      {\large \dateMY \par}
    \end{center}
    \par
    \@thanks
    \vfil\null
  \end{titlepage}
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\and\relax
  \cleardoublepage
}


% ====================================================================
\newcommand\resumen[1]{
\btypeout{Resumen}
\addtotoc{Resumen}
\thispagestyle{plain}
\null\vfil
%\vskip 60\p@
\begin{center}{\huge\bf Resumen\par}\end{center}
%\vskip 60\p@
{\normalsize #1}
\vfil\vfil\null
%\cleardoublepage
}


% ====================================================================
\newcommand\abstract[1]{
\btypeout{Abstract}
\addtotoc{Abstract}
\thispagestyle{plain}
\null\vfil
\begin{center}{\huge\bf Abstract\par}\end{center}
{\normalsize #1}
\vfil\vfil\null
}



\addtocounter{secnumdepth}{1}
\setcounter{tocdepth}{6}


% ====================================================================
% \renewcommand\tableofcontents{
%   \begin{spacing}{1}{
%       \setlength{\parskip}{1pt}
%       \pagenumbering{gobble}
%       \if@twocolumn
%       \@restonecoltrue\onecolumn
%       \else
%       \@restonecolfalse
%       \fi
%       \chapter*{\vspace{-2.0cm}\begin{center}\Large{\textbf{TABLA DE CONTENIDO}}\end{center}
%         \@mkboth{
%           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}
%       %\thispagestyle{empty}
%       \@starttoc{toc}
%       \if@restonecol\twocolumn\fi
%       \cleardoublepage
%      }\end{spacing}
%    \addtocontents{toc}{~\hfill{P\'ag.}\par}
%    %\vspace{-1.5cm}
%  }


% \renewcommand\tableofcontents{%
%   %\null\hfill\textbf{\Large{TABLA DE CONTENIDO}}\hfill\null\par
%   \hfill\textbf{\Large{TABLA DE CONTENIDO}}\hfill\null\par{$~$}\par
%   %{\vspace{-2.0cm}\begin{center}\Large{\textbf{TABLA DE CONTENIDO}}\end{center}
%   \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
%   \@starttoc{toc}%
%   %\vspace{3cm}
%   \addtocontents{toc}{\hfill{P\'ag.}\par}
%   %\vspace{-3cm}
% }

% \renewcommand\tableofcontents{
\cftsetindents{section}{0em}{2em}
\cftsetindents{subsection}{0em}{2.5em}
\renewcommand\contentsname{ff}
\renewcommand{\contentsname}{\centering Contents}
%\renewcommand\cfttoctitlefont{\hfill\Large\bfseries ff}
\renewcommand\cftaftertoctitle{\hfill\mbox{}}
%\setcounter{tocdepth}{2}

\renewcommand{\cftchapfont}{\bfseries CAP\'ITULO }
% \addtocontents{toc}{~\hfill{P\'ag.}\par}
\addtocontents{toc}{\hfill{P\'ag.}\par}
% }


%\RequirePackage{tocloft}
%\renewcommand{\cftchapfont}{\scshape d}
%\renewcommand{\cftchapfont}{\bfseries CAP\'ITULO }
%\renewcommand{\cftsecfont}{\bfseries}
% \renewcommand{\cftfigfont}{Figure }
% \renewcommand{\cfttabfont}{Table }


% ====================================================================
\renewcommand\listoffigures{
\begin{spacing}{1}{
    \setlength{\parskip}{1pt}
    \if@twocolumn
    \@restonecoltrue\onecolumn
    \else
    \@restonecolfalse
    \fi
    \chapter*{\vspace{-2.0cm}\begin{center}\Large{\textbf{ÍNDICE DE FIGURAS}}\end{center}
      \@mkboth{\MakeUppercase\listfigurename}
              {\MakeUppercase\listfigurename}}
    \@starttoc{lof}
    \if@restonecol\twocolumn\fi
    \cleardoublepage
}\end{spacing}
}


% ====================================================================
\renewcommand\listoftables{
  \begin{spacing}{1}{
    \setlength{\parskip}{1pt}
    \if@twocolumn
    \@restonecoltrue\onecolumn
    \else
    \@restonecolfalse
    \fi
    \chapter*{\vspace{-2.0cm}\begin{center}\Large{\textbf{ÍNDICE DE TABLAS}}\end{center}
      \@mkboth{
          \MakeUppercase\listtablename}{\MakeUppercase\listtablename}}
    \@starttoc{lot}
    \if@restonecol\twocolumn\fi
    \cleardoublepage
}\end{spacing}
}


% ====================================================================
% For the chapter
\def\@makechapterhead#1{%
  %\vspace*{50\p@}%
  {\parindent \z@ \centering
    \normalfont
    \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
    \Large\bfseries \@chapapp\space \thechapter
    \par\nobreak
    %\vskip 20\p@
    \fi
    \fi
    \interlinepenalty\@M
    \Large \bfseries #1\par\nobreak
    \vskip 40\p@
    \thispagestyle{empty}
  }}


\titleformat{\section}
  {\normalfont \bf}{\thesection}{1em}{}
\titleformat{\subsection}
  {\normalfont \bf}{\thesubsection}{1em}{}


% \renewcommand\backmatter{
%   \if@openright
%     \cleardoublepage
%   \else
%     \clearpage
%   \fi
%   \addtotoc{\bibname}
%   \btypeout{\bibname}
%   \@mainmatterfalse}
% \endinput

%%
%% End of file `tesisutec.cls'.
