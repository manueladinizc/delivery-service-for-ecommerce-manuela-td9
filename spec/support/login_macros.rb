def login_adm(user)
        click_on 'Entrar como usuário administrador'
        within('form') do
            fill_in 'E-mail', with: 'manuela@sistemadefrete.com.br'
            fill_in 'Senha', with: 'password'
            click_on 'Entrar'
        end
end


def login_regular(user)
    click_on 'Entrar como usuário regular'
    within('form') do
        fill_in 'E-mail', with: 'manu@sistemadefrete.com.br'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'
    end
end