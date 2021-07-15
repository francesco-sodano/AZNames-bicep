# Generate the aznames blabla

$definitions = Get-Content -Raw "sources/azure.resources.definition.json" |
    ConvertFrom-Json



Invoke-EPSTemplate -Path "sources/aznames.module.bicep.eps" -Binding @{
    definitions = $definitions
} -Helpers @{
    'ConvertTo-CamelCase' = { 
        Param($Name)
        [regex]::replace(
            $Name.ToLower(), 
            '(_)(.)', 
            { $args[0].Groups[2].Value.ToUpper()}) 
    }
}