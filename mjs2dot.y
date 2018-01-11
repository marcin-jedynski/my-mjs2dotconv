%{
#include <stdio.h>
#include <string.h>
char *lastValue="";
	int yydebug=1;
	void yyerror(const char *str)
	{
       	 fprintf(stderr,"error: %s\n",str);
	}

	int yywrap()
	{
       	 return 1;
	}

	int main()
	{

	 yyparse();
     	 printf("}\n");
	}

%}

%union
{
    char *str;
}



%token BOX_START BOX_END OVAL_START OVAL_END DIAMOND_START DIAMOND_END  DIRECTED NODIRECTED GRAPH_START 
%token <str> TITLE ID RANKDIR
%start programs
%%
programs:	| programs graph direction path;
graph:	| GRAPH_START {printf("\ngraph\{\n");};
direction:	| RANKDIR {printf("rankdir=%s;\n",$1);};
path:	node1st edge node2nd {printf("\n");}
	;
node1st:	id1stShape shape {printf(";\n%s",lastValue);}
       |	id1st;
node2nd:	id2ndShape shape {printf(";");}
       |	id2nd
       ;
shape:	BOX_START BOX_END {printf("[shape=box]");}
     |	BOX_START title BOX_END {printf("shape=box]");}
     |	OVAL_START OVAL_END {printf("shape=oval");}
     |	OVAL_START title OVAL_END {printf("shape=oval]");}
     |	DIAMOND_START  DIAMOND_END {printf("shape=diamond");}
     |	DIAMOND_START title DIAMOND_END {printf("shape=diamond]");}
     ;
title: TITLE {printf("[label=%s ",$1);}
     ;
id1st:	ID {printf("%s",$1);lastValue = malloc(sizeof(char)*strlen(yylval.str)); strcpy(lastValue, yylval.str);};
id1stShape:	ID {printf($1);lastValue = malloc(sizeof(char)*strlen(yylval.str)); strcpy(lastValue, yylval.str);};
id2nd:	ID {printf("%s;",$1);lastValue = malloc(sizeof(char)*strlen(yylval.str)); strcpy(lastValue, yylval.str);};
id2ndShape:	ID {printf("%s;\n%s",$1,$1);lastValue = malloc(sizeof(char)*strlen(yylval.str)); strcpy(lastValue, yylval.str);};
edge:	NODIRECTED {printf("--");}
    |	DIRECTED {printf("->");}
    ;
%%
