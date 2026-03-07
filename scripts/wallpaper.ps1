Add-Type -AssemblyName System.Windows.Forms

$Wallpapers = @(
    "cataratas.github.io/GPO/assets\wallpaper_orange.jpeg",
    "cataratas.github.io/GPO/assets\wallpaper_blue.jpeg"
)

$form = New-Object Windows.Forms.Form
$form.Text = "Select Wallpaper"
$form.Size = "400,300"

$list = New-Object Windows.Forms.ListBox
$list.Dock = "Fill"
$list.Items.AddRange($Wallpapers)

$button = New-Object Windows.Forms.Button
$button.Text = "Apply"
$button.Dock = "Bottom"

$button.Add_Click({
    $Wallpaper = $list.SelectedItem

    Copy-Item $Wallpaper "C:\Windows\Web\Wallpaper\" -Force

    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $Wallpaper
    rundll32.exe user32.dll, UpdatePerUserSystemParameters
})

$form.Controls.Add($list)
$form.Controls.Add($button)

$form.ShowDialog()