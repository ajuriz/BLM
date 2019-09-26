function []= script_2019_enero_v01(lado)

lado_grano_1=lado;
lado_grano_2=lado;

%Stage 1: For each grain size, the statistical parameters are assigned
% For the resistors "R" : the lognormal parameters "mu" and "sigma" are assigned
% For the Capacitors "C" : A vector of 100.000 elements is generated by the file which
% contains a samples of noise with the statistical properties required by each grain size. 

if (lado==40)  %size=40nm
       mu=-0.31393;
       sigma= 0.8072;
       
       celda=textread('3_p_lognormal_input_data_size_40','%s');
       ruido=zeros(100000,1);
       for ii=1:100000
           ruido(ii)=str2num(cell2mat(celda(ii)));
       end
elseif (lado==80) %size=80nm
        mu = -0.09702;
        sigma=0.4653;
        
       celda=textread('3_p_lognormal_input_data_size_80','%s');
       ruido=zeros(100000,1);
       for ii=1:100000
           ruido(ii)=str2num(cell2mat(celda(ii)));
       end
elseif (lado==138) %size=138nm
        mu = -0.034898;
        sigma=0.2785;
        celda=textread('3_p_lognormal_input_data_size_138','%s');
        ruido=zeros(100000,1);
        for ii=1:100000
           ruido(ii)=str2num(cell2mat(celda(ii)));
        end
elseif (lado==179) %size=179nm
        mu= -0.022858;
        sigma= 0.2160;
        celda=textread('3_p_lognormal_input_data_size_179','%s');
        ruido=zeros(100000,1);
        for ii=1:100000
           ruido(ii)=str2num(cell2mat(celda(ii)));
        end
elseif (lado==211) %size=211nm
        mu= -0.023737;
        sigma= 0.1787;
        celda=textread('3_p_lognormal_input_data_size_211','%s');
        ruido=zeros(100000,1);
        for ii=1:100000
           ruido(ii)=str2num(cell2mat(celda(ii)));
        end
elseif (lado==265) %size=265nm
       mu= -0.02722;
       sigma= 0.1394;
       celda=textread('3_p_lognormal_input_data_size_265','%s');
       ruido=zeros(100000,1);
       for ii=1:100000
          ruido(ii)=str2num(cell2mat(celda(ii)));
       end
end

%Stage 2: 10 models of each matrix size "N" are generated:
% iteration  1 to 10: N=3
% iteration 11 to 20: N=4
% iteration 21 to 30: N=5
% iteration 31 to 40: N=10
% iteration 41 to 50: N=20

for pasada=1 : 50 
   	if pasada <=10
        cantidad_filas=3;
        cantidad_columnas=3;
        cantidad_capas_deseadas=3;
    end
    if ((pasada<=20) & (pasada>10))
        cantidad_filas=4;
        cantidad_columnas=4;
        cantidad_capas_deseadas=4;
    end
    if ((pasada<=30) & (pasada>20))
            cantidad_filas=5;
            cantidad_columnas=5;
            cantidad_capas_deseadas=5;
    end
    if ((pasada<=40) & (pasada>30))
            cantidad_filas=10;
            cantidad_columnas=10;
            cantidad_capas_deseadas=10;
    end
     if ((pasada<=50) & (pasada>40))
            cantidad_filas=20;
            cantidad_columnas=20;
            cantidad_capas_deseadas=20;
     end
    
%Stage 3: A bricklayer model is generated according to the value of "N" selected.     
     
	cantidad_capas=cantidad_capas_deseadas-1;
	cantidad_nodos=cantidad_filas*cantidad_columnas*cantidad_capas;
	largo_fila= cantidad_columnas;
	tamano_cara= cantidad_filas*cantidad_columnas;
	indice=1;
	ii=1; 
	largo_vector=10000000;
	resistencias = ones(1,largo_vector);
    nodos = zeros(largo_vector,3);

	cara_1=zeros(cantidad_filas,cantidad_capas);
	cara_6=zeros(cantidad_filas,cantidad_capas);
	cara_2=zeros(cantidad_columnas,cantidad_capas);
	cara_5=zeros(cantidad_columnas,cantidad_capas);

	for k=1:cantidad_capas
	    for j=1:cantidad_columnas
		for a=1:cantidad_filas
		    if (a==1)
		        cara_2(j,k)=ii;
		    end
		    if (j==1)
		        cara_1(a,k)=ii;
		    end
		    if (a==cantidad_filas)
		        cara_5(j,k)=ii;
		    end
		    if (j==cantidad_columnas)
		        cara_6(a,k)=ii;
		    end
		    if  ((a < cantidad_filas)& (j < cantidad_columnas)& (k < cantidad_capas)) 
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+1;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+largo_fila;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+tamano_cara;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		    end
		    if  ((a==cantidad_filas)& (j < cantidad_columnas)& (k < cantidad_capas)) 
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+largo_fila;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+tamano_cara;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		    end
		    if  ((a<cantidad_filas)& (j== cantidad_columnas)& (k < cantidad_capas)) 
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+1;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+tamano_cara;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		    end
		    if  ((a<cantidad_filas)& (j< cantidad_columnas)& (k == cantidad_capas)) 
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+1;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+largo_fila;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		    end
		    if  ((a==cantidad_filas)& (j == cantidad_columnas)& (k < cantidad_capas)) 
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+tamano_cara;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		    end
		    if  ((a<cantidad_filas)& (j== cantidad_columnas)& (k == cantidad_capas)) 
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+1;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		    end
		    if  ((a==cantidad_filas)& (j< cantidad_columnas)& (k == cantidad_capas)) 
		        nodos(indice,1)=ii;
		        nodos(indice,2)=ii+largo_fila;
		        nodos(indice,3)=resistencias(indice);
		        indice=indice+1;
		    end
		    ii=ii+1;
		end
	    end
	end

	for k=1:cantidad_capas
		for a=1:cantidad_filas
		     nodos(indice,1)=cara_1(a,k);
		     nodos(indice,2)=cara_6(a,k);
		     nodos(indice,3)=resistencias(indice);
		     indice=indice+1;
		end
	end
	for k=1:cantidad_capas
	    for j=1:cantidad_columnas
		    nodos(indice,1)=cara_2(j,k);
		    nodos(indice,2)=cara_5(j,k);
		    nodos(indice,3)=resistencias(indice);
		    indice=indice+1;
	    end
	end
	    
	ultimo_nodo=ii;
    
	
%Stage 4: 
% The values of each resistor are obtained using the lognrnd() function of MatLab, and "mu" and "sigma" parameters of each grain size.
% The values of each capacitor are obtained from the vector generated in Stage 1.
% Althought, both are included in a new vector as the real part, and the
% complex part, the will be considered as separated components.

 resistencias_opt = lognrnd(mu, sigma, 1,indice-1) + i*ruido(1:indice-1,1)';

%Stage 5: 
%The corresponding values of each resistor and capacitor are assigned to each element of the bricklayer model generated in Stage 3.
    nodos_opt=zeros(indice-1,3);
	for ii=1: indice-1
	    nodos_opt(ii,1)= nodos(ii,1);
	    nodos_opt(ii,2)= nodos(ii,2);
	    nodos_opt(ii,3)= real(resistencias_opt(ii));
    end

%Zero value resistors are connected between the first components and the generator.
	nodos_aux=zeros(tamano_cara, 3);
	for ii =1:tamano_cara
	    nodos_aux(ii,1) = 0; % entre el nodo 0 y el i-esimo;
	    nodos_aux(ii,2) = ii;
	    nodos_aux(ii,3) = 0; % R=0; 
	end
	nodos_extra= nodos_aux;

%Zero value resistors are connected between the last components and the generator.
	nodos_aux=zeros(tamano_cara,3);
	for ii =1:tamano_cara
	    nodos_aux(ii,1) = ultimo_nodo; % entre el nodo indice y el (indice - i);
	    nodos_aux(ii,2) = ultimo_nodo-ii; % la variable "indice", ya qued� incrementada 
	    nodos_aux(ii,3) = 0; % R=0; 
	end
	nodos_extra= [nodos_aux ; nodos_extra];

	nodos_opt = [nodos_opt; nodos_extra];

%Stage 6: A PSPice "*.cir" file is generated for each iteration.
	
    fid = fopen(['Bricklayer_model_' num2str(lado_grano_1) '_' num2str(cantidad_filas) '_' num2str(pasada) '.cir'],'w');	  
	fprintf(fid,'*\n');
	for ii=1:length(nodos_opt)
	    fprintf(fid,'R%d ',ii);
	    fprintf(fid,'\t%d ',nodos_opt(ii,1));
	    fprintf(fid,'\t%d ',nodos_opt(ii,2));
	    if ii < indice
			fprintf(fid,'\t%8.4f ',real(resistencias_opt(ii)));
        else
            conexion=lognrnd(mu, sigma, 1,1);
            fprintf(fid,'\t%8.4f ',conexion);
	    end
	    fprintf(fid,'\n');
        fprintf(fid,'C%d ',ii);
	    fprintf(fid,'\t%d ',nodos_opt(ii,1));
	    fprintf(fid,'\t%d ',nodos_opt(ii,2));
	    if ii < indice
			fprintf(fid,'\t%6.15f ',imag(resistencias_opt(ii)));
        else
            conexion=ruido(round(rand(1)*length(ruido)));
            fprintf(fid,'\t%6.15f ',conexion);
	    end
	    fprintf(fid,'\n');
               
	end
	fprintf(fid,'V1');
	fprintf(fid,'\t%d ',0);
	fprintf(fid,'\t%d ',ultimo_nodo);
	fprintf(fid,'\tAC');
	fprintf(fid,'\t%6.4f ',1);
	fprintf(fid,'\n');

 	fprintf(fid,'.AC');
    fprintf(fid,'\tOCT');
 	fprintf(fid,'\t%d ',1);
 	fprintf(fid,'\t%d ',0.001);
 	fprintf(fid,'\t%d ',1000);
 	fprintf(fid,'\n');
 
 	fprintf(fid,'.PRINT');
 	fprintf(fid,'\t AC');
    fprintf(fid,'\t IR(V1)');
 	fprintf(fid,'\t II(V1)');
 	fprintf(fid,'\n');

	fprintf(fid,'.end');
	fclose(fid);
               
end
