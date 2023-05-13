import matplotlib.pyplot as plt

with open('resultados_fortran.txt', 'r') as f:
    dados_f = [linha.split() for linha in f]
    NxM = [str(l[0]) for l in dados_f]
    k = [int(l[1]) for l in dados_f]
    tempo1 = [float(l[2]) for l in dados_f]
    tempo2 = [float(l[3]) for l in dados_f]
    #Criando o gráfico
    fig = plt.figure()
    plt.plot(k, tempo1, label='Loop aninhado padrão')
    plt.plot(k, tempo2, label='Loop aninhado invertido')
    plt.legend()
    plt.xlabel('Iteração')
    plt.ylabel('Tempo de execução (s)')
    fig.savefig(
        "Gráficos/Resultado_Fortran.png", 
        dpi=fig.dpi
    )

with open('resultados_c.txt', 'r') as c:
    dados_c = [linha.split() for linha in c]
    NxM = [str(l[0]) for l in dados_c]
    k = [int(l[1]) for l in dados_c]
    tempo1 = [float(l[2]) for l in dados_c]
    tempo2 = [float(l[3]) for l in dados_c]
    #Criando o gráfico
    fig = plt.figure()
    plt.plot(k, tempo1, label='Loop aninhado padrão')
    plt.plot(k, tempo2, label='Loop aninhado invertido')
    plt.legend()
    plt.xlabel('Iteração')
    plt.ylabel('Tempo de execução (s)')
    fig.savefig(
        "Gráficos/Resultado_C.png", 
        dpi=fig.dpi
    )


