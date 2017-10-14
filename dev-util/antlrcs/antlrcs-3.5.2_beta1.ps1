try
{
Write-Host "Entring roll script"

# Add-Type -AssemblyName "ICSharpCode.SharpZLib, Version=0.86.0.762, Culture=neutral, PublicKeyToken=0738eb9f132ed756"

#$currentDir = [IO.Directory]::GetCurrentDirectory()

$DISTDIR="/var/portage-distdir"
$WORKDIR=/var/tmp/tarballs/dotnet/${CATEGORY}/${PN}

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
  /usr/bin/tartool $gzArchiveName
  
#  $file = [IO.File]::OpenRead($gzArchiveName)
#  $inStream = New-Object -TypeName [ICSharpCode.SharpZLib.GZip.GZipInputStream] $file
#  $tarIn = New-Object -TypeName [ICSharpCode.SharpZLib.Tar.TarInputStream] $inStream
#  $archive = [ICSharpCode.SharpZLib.Tar.TarArchive]::CreateInputTarArchive($tarIn)
#  $archive.ExtractContents($dstDir)
}
finally
{
#  $archive.Close
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
