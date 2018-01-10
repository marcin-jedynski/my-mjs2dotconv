%{
#include <stdio.h>
#include <string.h>
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
     	 printf("}");
	}

%}

%union
{
    char *str;
}



%token BOX_START BOX_END CIRCLE_START CIRCLE_END TRIANGLE_START TRIANGLE_END  DIRECTED NODIRECTED GRAPH_START 
%token <str> TITLE ID RANKDIR
%start programs
%%
programs:	|programs graph direction path;
graph:	|GRAPH_START {printf("\ngraph\{\n");};
direction:	|RANKDIR {printf("rankdir=%s\n",$1);};
path:	node edge node {printf("\n");}
	;
node:	id shape
    |	id title 
    |	id 
    ;
    
shape:	BOX_START BOX_END {printf("shape=box");}
     |	BOX_START title BOX_END {printf("shape=box]");}
     |	CIRCLE_START CIRCLE_END {printf("shape=circle");}
     |	CIRCLE_START title CIRCLE_END {printf("shape=circle, label=\"title\"");}
     |	TRIANGLE_START  TRIANGLE_END {printf("shape=triangle");}
     |	TRIANGLE_START title TRIANGLE_END {printf("shape=triangle, label=\"title\"");}
     ;
title: TITLE {printf("[label=%s ",$1);}
     ;
id:	ID {printf($1);}
  ;
edge:	NODIRECTED {printf("--");}
    |	DIRECTED {printf("->");}
    ;
%%
