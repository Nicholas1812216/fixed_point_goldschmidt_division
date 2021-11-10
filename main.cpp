/******************************************************************************

                              Online C++ Compiler.
               Code, Compile, Run and Debug C++ program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <iostream>
#include <fstream>

using namespace std;

int main()
{
    float x = 121.2;
    float comp;
    float x_val;
    char frac[16];

    
    ofstream myfile;
    myfile.open("ROM_data.txt");
    
    for(int i = 0;i<1024;i++)
    {
        
        x = 1.0/(i * 64.0);
        if(i == 0)
        {
            x_val = 1.0/63.0;
        }
        else
        {
            x_val = x;
        }
        // cout<<x_val<<"  ";
        
       // myfile<<"0000000000000000";     
        
        comp = 0.5;
        for(int j = 0;j < 16;j++)
        {
            if(x_val >= comp) 
            {
                frac[j] = '1';
                x_val = x_val - comp;
            }
            else
            {
                frac[j] = '0';
            }
            
            comp = comp/2.0;
            cout<<frac[j];
            myfile<<frac[j];
        }
        cout<<"\n";
        myfile<<"\n";

        
    }
    myfile.close();

    return 0;
}
