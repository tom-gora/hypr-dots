NOTE: Because entire config directory for VSCode/Codium takes up massive amounts
of storage and mostly stores state, backups and other non-static content this 
directory contains only essentials and everything needs to be manually sorted out
and manually backed up from actual config files to here as per below points:

1. Profiles go into ./User/profiles/

2. "vscodevim.vim" directory goes into ./User/globalStorage/

3. Custom snippets go into ./User/snippets/


4. Extensions can be installed via ./User/Extensions-Install/code-install.sh
NOTE: codium default store does not have many of the listed extensions. 
As far as I was able to determine the product.json workaround to configure actual
Microsoft extensions gallery to work in Codium  is non-viable anymore.
It's either free software or manual labor as it always was ;)
Manual installation is done via VSIX files.



