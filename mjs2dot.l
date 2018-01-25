%{
#include "y.tab.h"
%}

yy_flex_debug= 1;
%%
graph 	{return GRAPH_START ;}
--> 	{return DIRECTED ;}
--- 	{return NODIRECTED ;}
=== 	{return NODIRECTED_BOLD ;}
-.- 	{return NODIRECTED_DOTTED ;}
\[	{return BOX_START ;}
\]	{return BOX_END ;}
\(	{return OVAL_START ;}
\)	{return OVAL_END ;}
\{	{return DIAMOND_START ;}
\}	{return DIAMOND_END ;}
TB|BT|RL|LR|TD	{yylval.str = strdup(yytext); return RANKDIR ;}
\"[a-zA-Z0-9]+\" 	{yylval.str = strdup(yytext); return TITLE ;}
[a-zA-Z0-9]+	{yylval.str = strdup(yytext); return ID;}

\n	;
[ \t]+	;

%%

