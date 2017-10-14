try
{
Write-Host "Entring roll script"

try
{

$DISTDIR="/var/portage-distdir"

$gzArchiveName=Join-Path -Path $DISTDIR -ChildPath "antlrcs-3.5.2_beta1_p6.tar.gz"

if (Test-Path $gzArchiveName)
{
    Write-Host "File is already downloaded"
    Write-Host $gzArchiveName
}
else
{
    # Load sources from github
    $uri = "https://github.com/antlr/antlrcs/tarball/ca331b7109e1faa5a6aa7336bb6281ce9363e62b"
    Write-Host "Downloading from URL"
    Write-Host $uri
    $wc = New-Object -TypeName System.Net.WebClient
    $wc.DownloadFile($uri, $gzArchiveName)
}

}
catch
{
    Write-Host "Exception during downloading"
    throw;
}

$CATEGORY="dev-util"
$PN="antlrcs"

$WORKDIR="/var/tmp/tarballs/shnurise"
$WORKDIR=Join-Path -Path $WORKDIR -ChildPath $CATEGORY
$WORKDIR=Join-Path -Path $WORKDIR -ChildPath $PN
if (Test-Path $WORKDIR)
{
    Write-Host "Working directory already exists"
    Write-Host $WORKDIR
}
else
{
    New-Item -ItemType Directory -Force -Path $WORKDIR | Out-Null
}

try
{
    Add-Type -AssemblyName "ICSharpCode.SharpZLib, Version=0.86.0.762, Culture=neutral, PublicKeyToken=0738eb9f132ed756"
  
    $file = [IO.File]::OpenRead($gzArchiveName)
    $inStream=New-Object -TypeName ICSharpCode.SharpZipLib.GZip.GZipInputStream $file
    $tarIn = New-Object -TypeName ICSharpCode.SharpZipLib.Tar.TarInputStream $inStream
    $archive = [ICSharpCode.SharpZipLib.Tar.TarArchive]::CreateInputTarArchive($tarIn)
    $archive.ExtractContents($WORKDIR)
}
finally
{
    $archive.Close | Out-Null
}

$S = Get-ChildItem -path $WORKDIR -filter | Select-Object -Expand FullName
Write-Host "`$S=`"$S`""

# prepare sources 
## replace files
## apply patches
## run generators
## remove binary files
# archive source into single file

Write-Host "Exiting roll script"

}
catch
{
    Write-Host "Outer exception:"
    Write-Host $_.Exception.GetType().FullName, $_.Exception.Message, $_.Exception.ToString()
}
