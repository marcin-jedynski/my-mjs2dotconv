%{
    #include <stdio.h>
    #include <string.h>

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
    }

%}

%union
{
    char *str;
}



%token BOX_START BOX_END CIRCLE_START CIRCLE_END TRIANGLE_START TRIANGLE_END  DIRECTED NODIRECTED 
%token <str> TITLE ID RANKDIR
%%
commands:	
	|	root commands 
	;
root: node
    |	shape
    |	title
    | id
    ;
node:	id 
    |	id shape 
    |	id title {printf("shape=box, label=\"title\"");}
    ;
    
shape:	BOX_START BOX_END {printf("shape=box");}
     |	BOX_START TITLE BOX_END {printf("shape=box, label=\"title\")");}
     |	CIRCLE_START CIRCLE_END {printf("shape=circle");}
     |	CIRCLE_START TITLE CIRCLE_END {printf("shape=circle, label=\"title\"");}
     |	TRIANGLE_START  TRIANGLE_END {printf("shape=triangle");}
     |	TRIANGLE_START TITLE TRIANGLE_END {printf("shape=triangle, label=\"title\"");}
     ;
title: TITLE {printf("Title is: %s",$1);}
     ;
id:	ID {printf("shape=box, label=\"id\"");}
  ;
%%
