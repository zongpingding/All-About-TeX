\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass{beautybook}    
                  {2024-05-28}  % Date
                  {0.0.1}       % Version
                  {a~template}  % Description


% % options
\RequirePackage {l3keys2e}

\keys_define:nn { beautybook / option}{
    layout        .str_gset:N   =  \l__beautybook_layout_str,
    layout        .initial:n    =  { a4paper },
}
\ProcessKeysOptions {beautybook / option}
% basic class
\LoadClass{article}

% option check
\str_case:VnF \l__beautybook_layout_str {
    {a4paper}{\def\test{current~ layout~ option~ is:~'a4paper'}}
    {letterpaper}{\def\test{current~ layout~ option~ is:~'letterpaper'}}
}{\relax}