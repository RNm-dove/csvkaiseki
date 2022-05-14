BEGIN {
        srand();
        printf("f1,f2,f3\n");
        for(i=1; i<=1000000; i++){
                printf("%d,%d,%d\n",
                substr(rand(), 3),
                i%47,
                i%40 );
        }
}