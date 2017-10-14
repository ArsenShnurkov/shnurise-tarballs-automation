function WebDownload ( $url, $fullFileName )
{
    try
    {
        if (Test-Path $fullFileName)
        {
            Write-Host "File `"$fullFileName`" is already downloaded "
        }
        else
        {
            # Load sources from github
            Write-Host "Downloading from URL $url"
            $wc = New-Object -TypeName System.Net.WebClient
            $wc.AllowAutoRedirect = $true
            $wc.DownloadFile($url, $fullFileName)
        }
    }
    catch
    {
        Write-Host "Exception during WebDownload"
        throw;
    }
}

try
{
Write-Host "Entring roll script"

$DISTDIR="/var/portage-distdir"

$gzArchiveName=Join-Path -Path $DISTDIR -ChildPath "antlrcs-3.5.2_beta1_p6.tar.gz"
$GithubUrl="https://github.com/antlr/antlrcs/tarball/ca331b7109e1faa5a6aa7336bb6281ce9363e62b"

$wc = New-Object -TypeName "System.Net.WebClient"
if ( $ws -eq $null )
{
    Write-Host "`$ws is $ws"
    Write-Host "..."
}
$wc.MaximumAutomaticRedirections=1
$wc.AllowAutoRedirect=[System.Boolean]::true
$wc.DownloadFile($GithubUrl, $gzArchiveName)

WebDownload $GithubUrl $gzArchiveName


$CATEGORY="dev-util"
$PN="antlrcs"

$WORKDIR="/var/tmp/tarballs/shnurise"
$WORKDIR=Join-Path -Path $WORKDIR -ChildPath $CATEGORY
$WORKDIR=Join-Path -Path $WORKDIR -ChildPath $PN

$DISTDIR=Join-Path -Path $WORKDIR -ChildPath "distdir"

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

$S = Get-ChildItem -path $WORKDIR | where { $_.Name -match ".*-$PN-.*" } | Select-Object -Expand FullName
Write-Host "`$S=`"$S`""

$urlAntlr3Codegenerator="https://www.nuget.org/api/v2/package/Antlr3.CodeGenerator/3.5.2-beta1"
$archiveName="antlr3.codegenerator.3.5.2-beta1.nupkg"
$fullArchiveName=Join-Path -Path $DISTDIR -ChildPath $archiveName

#Write-Host "$urlAntlr3Codegenerator $fullArchiveName"

WebDownload "$urlAntlr3Codegenerator" "$fullArchiveName"

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
