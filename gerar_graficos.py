import matplotlib.pyplot as plt

for linguagem in ['C', 'Fortran']:
    with open(f'resultados_{linguagem}.txt', 'r') as resultados:
        dados = [linha.split() for linha in resultados]
        k = [int(l[1]) for l in dados]
        tempo1 = [float(l[2]) for l in dados]
        tempo2 = [float(l[3]) for l in dados]
        #Criando o gráfico
        fig = plt.figure()
        plt.plot(k, tempo1, label='Loop aninhado padrão')
        plt.plot(k, tempo2, label='Loop aninhado invertido')
        plt.title(f'Desempenho em {linguagem}')
        plt.legend()
        plt.xlabel('Iteração')
        plt.ylabel('Tempo de execução (s)')
        fig.savefig(
            f"Gráficos/Resultado_{linguagem}.png", 
            dpi=fig.dpi
        )


