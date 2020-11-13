
#include<iostream>
#include<fstream>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
#include <vector>
#include <algorithm>


using namespace std;

class Lexer {
  public:
    int checkForKeyword(string str)
    {
        int flag = 0;
        const vector<string> keywords{"auto","break","case","char","const","continue","default",
							"do","double","else","enum","extern","float","for","goto",
							"if","int","long","register","return","short","signed",
							"sizeof","static","struct","switch","typedef","union",
							"unsigned","void","volatile","while","string"};
        for(string keys : keywords)
            if (keys == str)
                flag = 1;
                return flag;
        return flag;
    }


    int checkString(string str){
        int flag = 0;
        if(str[0] == '"' && str[str.size()-1] == '"'){
            flag = 1;
            return flag;
        }
            return flag;
    }


    int checkNum(string num){
        int flag = 0;

        if(std::all_of(num.begin(), num.end(), ::isdigit)){
                cout<<"The number is "<<num;
            flag = 1;
        }
        return flag;
    }

    int checkSpecialSymbols(string symbol){
        int flag = 0;
        //cout<<symbol;
        vector<string> specialSymbols{"[", "]", "(", ")", "{", "}", ";", ":", ",", "#"};
        for(string specialsymbol : specialSymbols)
            if (specialsymbol == symbol)
                flag = 1;
                return flag;
        return flag;
    }

    int checkComments(string str){
        int flag = 0;
        vector<string> comments{"//", "/*", "*/"};
        for(string comment : comments)
            if (comment == str)
                flag = 1;
                return flag;
        return flag;
    }


    int checkOperators(string str)
    {
        int flag = 0;
        const vector<string> operators{"<", ">", "<=", ">=", "*", "+", "-", "/", "=", "-=", "*=", "+=", "/=", "++", "--", "=="};
        for(string op : operators)
            if (op == str)
                flag = 1;
                return flag;

        return flag;
    }


};


int main(){
    //create the lexer object
    Lexer lexer_obj;

	//char ch, buffer[15];
	char buffer[30];
	int j = 0;
    string str;
    string word;
    string::size_type i=0;

	ifstream fin;
	fin.open("programs.txt");


	if(!fin.is_open()){
		cout<<"Error encountered while opening the file\n";
		exit(0);
	}


	// extracting words from the file
    while (fin >> word)
    {
        if(lexer_obj.checkOperators(word)){
            cout<< word <<" is an operator\n";
        } else if(lexer_obj.checkString(word)){
            cout << word <<" is a string\n";
        } else if(lexer_obj.checkNum(word)){
            cout<< word <<" is a number\n";
        } else if(lexer_obj.checkSpecialSymbols(word)){
            cout<< word <<" is a special symbol\n";
        } else if(lexer_obj.checkComments(word)){
            cout<< word <<" is a Comment\n";
        } else if(lexer_obj.checkForKeyword(word)){
            cout<< word <<" is a keyword\n";
        } else  {
            int w;
            //cout<<word <<" The word\n";
            for( w = 0; w < word.length(); w++){
                    if(std::isalnum(word[w])){
                        buffer[j++] = word[w];

                    }
            }

            buffer[j] = '\0';
            j = 0;
            cout<<buffer<<" is an identifier\n";
        }
    }



	fin.close();

	return 0;
}
