try
{
Write-Host "Entring roll script"

#Add-Type -AssemblyName "ICSharpCode.SharpZipLib, Version=4.84.0.0, Culture=neutral, PublicKeyToken=1b03e6acf1164f73"

#$currentDir = [IO.Directory]::GetCurrentDirectory()
#$gzArchiveName = Join-Path -Path $currentDir -ChildPath 'outputfile.tar.gz'

# DISTDIR="/var/portage-distdir"

# Load sources from github
$uri = "https://github.com/antlr/antlrcs/archive/ca331b7109e1faa5a6aa7336bb6281ce9363e62b.tar.gz"

$gzArchiveName="/var/portage-distdir/antlrcs-3.5.2_beta1_p6.tar.gz"
Write-Host $gzArchiveName

# $wc = New-Object -TypeName System.Net.WebClient
#    $wc.DownloadFile($uri, $gzArchiveName)

# unpack sources
$inStream = [IO.File]::OpenRead($gzArchiveName)
$gzipStream = New-Object System.IO.Compression.GZipStream

# prepare sources 
## replace files
## apply patches
## run generators
## remove binary files
# archive source into single file

Write-Host "Exiting roll script"

}
catch 
# [Exception]
{
    echo $_.Exception.GetType().FullName, $_.Exception.Message, $_.Exception.ToString()
}
