new forveh_vehicles[MAX_VEHICLES];
new forveh_count = 0;

#if !defined IsValidVehicle
     native IsValidVehicle(vehicleid);
#endif

#define forveh(%0) for(new ouf, %0=forveh_vehicles[ouf]; ouf<forveh_count; %0=forveh_vehicles[++ouf])

stock Forveh_CreateVehicle(modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, respawn_delay)
{
    new vehid = CreateVehicle(modelid, x, y, z,angle, color1, color2, respawn_delay);
    forveh_vehicles[forveh_count++]=vehid;
    return vehid;
}
#if defined _ALS_CreateVehicle
     #undef CreateVehicle
#else
     #define _ALS_CreateVehicle
#endif
#define CreateVehicle Forveh_CreateVehicle

stock Forveh_AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:angle, color1, color2)
{
    new vehid = AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, angle, color1, color2);
    forveh_vehicles[forveh_count++]=vehid;
    return vehid;
}
#if defined _ALS_AddStaticVehicle
     #undef AddStaticVehicle
#else
     #define _ALS_AddStaticVehicle
#endif
#define AddStaticVehicle Forveh_AddStaticVehicle

stock Forveh_AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:angle, color1, color2, respawn_delay)
{
    new vehid = AddStaticVehicleEx(modelid, spawn_x, spawn_y, spawn_z, angle, color1, color2,respawn_delay);
    forveh_vehicles[forveh_count++]=vehid;
    return vehid;
}
#if defined _ALS_AddStaticVehicleEx
    #undef AddStaticVehicleEx
#else
    #define _ALS_AddStaticVehicleEx
#endif
#define AddStaticVehicleEx Forveh_AddStaticVehicleEx

stock Forveh_DestroyVehicle(vehicleid)
{
    if(!IsValidVehicle(vehicleid)) return 0;
    for(new i=0;i<forveh_count;i++)
    {
        if(forveh_vehicles[i]==vehicleid)
        {
            forveh_vehicles[i]=forveh_vehicles[--forveh_count];
            break;
        }
    }
    return DestroyVehicle(vehicleid);
}
#if defined _ALS_DestroyVehicle
    #undef DestroyVehicle
#else
    #define _ALS_DestroyVehicle
#endif
#define DestroyVehicle Forveh_DestroyVehicle 