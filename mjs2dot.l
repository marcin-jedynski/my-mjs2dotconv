%{
#include "y.tab.h"
%}

%%
--> 	{ECHO;return DIRECTED ;}
-- 	{ECHO;return NODIRECTED ;}
\[	{ECHO;return BOX_START ;}
\]	{ECHO;return BOX_END ;}
\(	{ECHO;return CIRCLE_START ;}
\)	{ECHO;return CIRCLE_END ;}
\{	{ECHO;return TRIANGLE_START ;}
\}	{ECHO;return TRIANGLE_END ;}
.+	{ECHO;yylval.str = strdup(yytext); return ID;}
\".+\"\n 	{ECHO;yylval.str = strdup(yytext); return TITLE ;}
TB|BT|RL|LR|TD	{ECHO;yylval.str = strdup(yytext); return RANKDIR ;}
%%

