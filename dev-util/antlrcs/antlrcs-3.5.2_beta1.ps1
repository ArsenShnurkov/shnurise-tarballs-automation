try
{
Write-Host "Entring roll script"

Add-Type -AssemblyName "ICSharpCode.SharpZipLib, Version=4.84.0.0, Culture=neutral, PublicKeyToken=1b03e6acf1164f73"

$currentDir = [IO.Directory]::GetCurrentDirectory()

# DISTDIR="/var/portage-distdir"

# Load sources from github
$uri = "https://github.com/antlr/antlrcs/archive/ca331b7109e1faa5a6aa7336bb6281ce9363e62b.tar.gz"

$gzArchiveName="/var/portage-distdir/antlrcs-3.5.2_beta1_p6.tar.gz"
Write-Host $gzArchiveName

# $wc = New-Object -TypeName System.Net.WebClient
#    $wc.DownloadFile($uri, $gzArchiveName)

# unpack sources
$dstDir=Join-Path -Path $currentDir -ChildPath 'work'

try
{
  $file = [IO.File]::OpenRead($gzArchiveName)
  $inStream = New-Object -TypeName [ICSharpCode.SharpZipLib.GZip.GZipInputStream] $file
  $tarIn = New-Object -TypeName [ICSharpCode.SharpZipLib.Tar.TarInputStream] $inStream
  $archive = [ICSharpCode.SharpZipLib.Tar.TarArchive]::CreateInputTarArchive($tarIn)
  $archive.ExtractContents($dstDir)
}
finally
{
  $archive.Close
#  $tarIn.Close
#  $file.Close
}


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
