#include <iostream>
#include <stdlib.h>

using namespace std;

#define TAM 10

void print(int * vec, int tam){
	for(int i=0; i<tam; i++)
		cout<<vec[i]<<" ";
	cout<<endl;
}

int * crip(int *vec, int tam){
	int *aux;
	aux = (int *)malloc(tam*sizeof(int));
	aux[tam-1]=vec[tam-1];
	for(int i=tam-2; i>=0; i--){
		aux[i]=vec[i]-vec[i+1]; 
		if(aux[i]<0)
			aux[i] = 255 + aux[i];
	}
	vec=aux;
	cout<<"Criptografado: ";
	return vec;
}

int * descrip(int *vec, int tam){
	int *aux;
	aux = (int *)malloc(tam*sizeof(int));
	aux[tam-1]=vec[tam-1];
	for(int i=tam-2; i>=0; i--){
		aux[i]=vec[i]+aux[i+1]; 
		if(aux[i]>255)
			aux[i] = aux[i] - 255;
	}
	vec=aux;
	cout<<"Descriptografado: ";
	return vec;
}

int main(){
	int *vec, aux[TAM] = {48, 56, 49, 54, 54, 50, 57, 54, 50, 48};
	vec = (int *)malloc(TAM*sizeof(int));
	for(int i=0; i<TAM; i++)
		vec[i]=aux[i];
	cout<<"Original: ";
	print(vec, TAM);
	vec=crip(vec, TAM);
	print(vec, TAM);
	vec=descrip(vec, TAM);
	print(vec, TAM);
}